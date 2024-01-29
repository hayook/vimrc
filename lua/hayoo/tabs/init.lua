require("hayoo.tabs.popup")
require("hayoo.tabs.temp")

local function extractFileName(filePath)
	local fileName = string.match(filePath, "[\\/]([^\\/]*)$") -- Match the last part after the last backslash or forward slash
	if fileName == nil then
		return filePath
	end
	return fileName
end

function GetFileIdx(fileId, files)
	for idx, file in ipairs(files) do
		if fileId == file.fileId then return idx end
	end
	return nil
end

function GetOpenFiles()
	local files = {}
	local open_bufs = vim.fn.getbufinfo({ buflisted = 1 })
	for idx, buf in ipairs(open_bufs) do
		local file = {
			fileId = buf.bufnr,
			relativePath = vim.fn.bufname(buf.bufnr),
			changed = buf.changed == 1,
			fileRef = idx,
			current = true
		}
		table.insert(files, file)
	end
	local currentFileId = vim.fn.bufnr('%')
	local currentFileRef = GetFileIdx(currentFileId, files)
	return { list = files, currentFileRef = currentFileRef }
end

function ProduceLines(files)
	local text = {}
	local danger = {}
	for count, file in ipairs(files.list) do
		-- (Beta) - local changedSymbol = file.changed and "[+]" or "   "
		local line = file.fileRef .. ". " .. extractFileName(file.relativePath)
		table.insert(text, line)
		if file.changed then table.insert(danger, count) end
	end
	return { text = text, danger = danger, currentFileRef = files.currentFileRef }
end

function DisplayOpenFiles()
	local files = GetOpenFiles()
	local lines = ProduceLines(files)
	local current_winid = vim.fn.win_getid(vim.fn.winnr())
	local win
	local handlers = {}

	local function open_file_handler()
		local fileRef = vim.fn.line(".") - 1
		if fileRef < 1 then return end
		vim.api.nvim_command(":q")
		vim.api.nvim_set_current_buf(files.list[fileRef].fileId)
	end

	local function close_file_handler()
		local fileRef = vim.fn.line(".") - 1
		if fileRef < 1 then return end
		local targetFileId = files.list[fileRef].fileId
		local altFileId = GetAlternativeFile(files, targetFileId)
		vim.api.nvim_win_set_buf(current_winid, altFileId)
		local res = DeleteFile(files, targetFileId)
		files = GetOpenFiles()
		if #files.list == 0 then
			vim.api.nvim_command(":q")
			return
		end

		files.currentFileRef = GetFileIdx(altFileId, files.list)
		lines = ProduceLines(files)
		Render(lines, win)
	end

	handlers.open_file_handler = open_file_handler
	handlers.close_file_handler = close_file_handler

	win = CreatePopup(handlers)
	Render(lines, win)
end

-- open tab view
vim.keymap.set("n", "<leader>tt", DisplayOpenFiles)


function CloseFile()
	local files = GetOpenFiles()
	if files.currentFileRef == nil then
		vim.api.nvim_err_writeln("[HAYOO] No open files to close.")
		return
	end
	local altFileId = GetAlternativeFile(files, files.list[files.currentFileRef].fileId)
	local currentFileId = files.list[files.currentFileRef].fileId
	if not files.list[files.currentFileRef].changed then vim.api.nvim_command(":b " .. altFileId) end
	DeleteFile(files, currentFileId)
end

vim.keymap.set("n", "<leader>tw", CloseFile)

-- Navigation between files
vim.keymap.set("n", "<leader>th", ":bp<CR>")
vim.keymap.set("n", "<leader>tl", ":bn<CR>")
vim.keymap.set("n", "<leader>ts", ":w<CR>")
vim.keymap.set("n", "<leader>tq", ":q<CR>")
