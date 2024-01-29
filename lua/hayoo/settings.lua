-- set the EndOfLIne character to LF
vim.opt.fileformat = "unix";

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

-- not pretty sure about these may change based on the experience
vim.opt.scrolloff = 9
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- i don't know what this does
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

-- Disable mouse
vim.opt.mouse = ""
