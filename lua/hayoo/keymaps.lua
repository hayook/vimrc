-- Horizontal scrolling
vim.keymap.set('n', '<C-l>', '2zl')
vim.keymap.set('n', '<C-h>', '2zh')

-- Move lines up and down
vim.keymap.set('n', '<C-j>', ':m .+1<CR>==', { noremap = true })
vim.keymap.set('n', '<C-k>', ':m .-2<CR>==', { noremap = true })
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv")

-- iam not pretty sure about this may change based on the experience 
vim.keymap.set("n", "J", "mcJ`c")

-- Move by one paragraph vertically and center cursor
vim.keymap.set('n', '{', '{zz', { noremap = true })
vim.keymap.set('n', '}', '}zz', { noremap = true })

-- Move to the end of the file and center cursor
vim.keymap.set('n', 'G', 'Gzz', { noremap = true })

-- Move between search results and center them
vim.keymap.set('n', 'n', 'nzz', { noremap = true })
vim.keymap.set('n', 'N', 'bzz', { noremap = true })

-- Remove search highlights
vim.keymap.set('n', '<C-m>', ':noh<CR>', { noremap = true })

-- Move half page and center the cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-f>", "<C-u>zz")

vim.keymap.set({ "i", "c" }, "kj", "<ESC>")
