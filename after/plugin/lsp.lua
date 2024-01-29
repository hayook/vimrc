local lsp_zero = require('lsp-zero')


lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

lspconfig = require("lspconfig")
local lua_opts = lsp_zero.nvim_lua_ls()

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		"lua_ls",
		"tsserver",
		"lua_ls",
		"eslint",
	},
	handlers = {
		lsp_zero.default_setup,
		tsserver = function()
			lspconfig.tsserver.setup({})
		end,
		lua_ls = function()
			lspconfig.lua_ls.setup(lua_opts)
		end,
		eslint = function()
			lspconfig.eslint.setup({
				on_attach = function(client, bufnr)
					print("Hello")
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})
		end

	},
})

local cmp = require('cmp')

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-x>"] = cmp.mapping.close(),
		["<TAB>"] = cmp.mapping.confirm({ select = true }),
	}),
	performance = {
		max_view_entries = 10,
	}
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
	'confirm_done',
	cmp_autopairs.on_confirm_done()
)
