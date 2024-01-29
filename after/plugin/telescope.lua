require('telescope').setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			".git",
			"env",
		},

		mappings = {
			i = {
				["<C-c>"] = "close",

			},
			n = {
				["<C-c>"] = "close",
			}
		}
	}
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
