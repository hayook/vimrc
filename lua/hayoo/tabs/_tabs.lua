local function close_file()
	local cur_bufnr = vim.api.nvim_get_current_buf()
	local success, result = pcall(function() vim.api.nvim_buf_delete(cur_bufnr, {}) end)
	if not success then
		vim.api.nvim_err_writeln("[HAYOO] Save before close")
		return
	end
	vim.api.nvim_command('bnext')
end

local function _close_file()
	local open_bufs = vim.fn.getbufinfo({ buflisted = 1 })
	if #open_bufs == 0 then
		vim.api.nvim_err_writeln("[HAYOO] No files to close.")
		return
	end
	local cur_bufnr = vim.api.nvim_get_current_buf()
	local cur_buf_idx = get_buf_index(cur_bufnr, open_bufs)
	if cur_buf_idx == nil then
		vim.api.nvim_err_writeln("[HAYOO] No files to close.")
		return
	end
	local next_buf_idx = cur_buf_idx + 1
	if next_buf_idx > #open_bufs then
		next_buf_idx = 1
	end
	local next_bufnr = open_bufs[next_buf_idx].bufnr
	local success, result = pcall(function() vim.api.nvim_buf_delete(cur_bufnr, {}) end)
	if not success then
		vim.api.nvim_err_writeln("[HAYOO] Save before close")
	end
	if next_buf_idx ~= cur_buf_idx then
		vim.api.nvim_set_current_buf(next_bufnr)
		return
	end
	local wins = vim.api.nvim_list_wins()
	print("  " .. #wins)
end

function get_buf_index(bufnr, bufs)
	for i, buf in ipairs(bufs) do
		if buf.bufnr == bufnr then
			return i
		end
	end
	return i
end

vim.keymap.set("n", "<leader>tc", close_file)



local function extractFileName(filePath)
	local fileName = string.match(filePath, "[\\/]([^\\/]*)$") -- Match the last part after the last backslash or forward slash
	if fileName == nil then
		return filePath
	end
	return fileName
end

local function list_files()
	local tabs = " | "
	local open_bufs = vim.fn.getbufinfo({ listed = 1 })
	for _, buf in ipairs(open_bufs) do
		tabs = tabs .. extractFileName(buf.name) .. " | "
	end
	print(tabs)
end

vim.keymap.set("n", "<leader>ts", list_files)
