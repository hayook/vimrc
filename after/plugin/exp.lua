-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


api = require "nvim-tree.api"

local function my_on_attach(bufnr)

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "<leader>b", ":NvimTreeFindFileToggle<CR>")
end

-- setup with some options
require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},
	git = {
		enable = false,
	},
	filters = {
		dotfiles = false, -- default value but doesn't work
		custom = {"^\\.git" },
	},
	view = {
		width = 26,
	},
	renderer = {
		group_empty = false,
		add_trailing = true,
		indent_markers = {
			enable = true
		},
		icons = {
			show = {
				file = false,
				folder = false,
				folder_arrow = true,
				git = false,
				modified = false,
				diagnostics = false,
				bookmarks = false,
			},
			glyphs = { 
				default = "C", -- for files but doesn't work 
				folder = {
					arrow_closed = "►",
					arrow_open = "▼",
					default = "D",
				},
			}
		},
	},
	filters = {
		dotfiles = true,
	},
	on_attach = my_on_attach,
})

api.tree.toggle_hidden_filter()
