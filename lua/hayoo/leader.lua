-- Change leader key to ' '
vim.g.mapleader = ' '

-- Map opening clipboard register
vim.keymap.set({ "x", "n" }, "<leader>c", '"+')

-- Copy and replace without loosing the content of the register
vim.keymap.set("v", "<leader>r", '"_s<ESC>P')

-- replace the currunt word/line/selected text in the whole file
vim.keymap.set("n", "<leader>ew", ":%s/<C-r><C-w>>/")
vim.keymap.set("n", "<leader>el", ":%s/<C-r><C-l>/")
vim.keymap.set("v", "<leader>ev", ":s/\\%V.*\\%V/")

-- Move to the begening/end of the line
vim.keymap.set({ 'n', 'v', 'x', 's', 'o' }, "<leader>h", "^")
vim.keymap.set({ 'n', 'v', 'x', 's', 'o' }, "<leader>l", "g_")

-- Format using '<leader>e' instead of "="
vim.keymap.set("x", "<leader>f", "=")
vim.keymap.set("n", "<leader>fl", "==")
vim.keymap.set("n", "<leader>fp", "mc=ap`c")
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format)

-- Select the whole file using '<leader>sf'
vim.keymap.set("n", "<leader>sf", "ggVG")


-- temp <leader>w to '<C-w>'
vim.keymap.set("n", "<leader>w", "<C-w>")

-- Quick insertion
vim.keymap.set("n", "<leader>io", "mco<ESC>`c")
vim.keymap.set("n", "<leader>iO", "mcO<ESC>`c")
