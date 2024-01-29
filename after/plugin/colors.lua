function CustomizeTheme(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "black" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "black" })
	vim.api.nvim_set_hl(0, "cursorLine", { underline = true })
end

CustomizeTheme()

function HighlightSyntax()
	local pallet = {
		["@keyword"] = { fg = "#e25737" },
		["@keyword.new"] = { fg = "#e25737" },
		["@repeat"] = { fg = "#e25737" },
		["Conditional"] = { fg = "#e25737" },
		["@variable"] = { fg = "white" },
		["@variable.builtin"] = { fg = "#f58065" },
		["@function.builtin"] = { fg = "#f58065" },
		["@constant"] = { fg = "yellow" },
		["@method"] = { fg = "white" },
		["@punctuation"] = { fg = "white" },
		["@string"] = { fg = "#FF8C00" },
	}
	for capture, opts in pairs(pallet) do
		vim.api.nvim_set_hl(0, capture, opts)
	end
end

HighlightSyntax()

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#highlights
-- :h treesitter-highlight
