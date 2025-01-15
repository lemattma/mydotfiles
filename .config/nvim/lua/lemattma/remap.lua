vim.g.mapleader = " "

-- Toggle explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Go to normal mode
vim.keymap.set("i", "jj", "<ESC>")

-- Go to normal and save
vim.keymap.set("i", ",,", "<ESC>:w<CR>")

-- Save
vim.keymap.set("n", ",,", ":w<CR>")
vim.keymap.set("n", "<leader>,", ":w<CR>")

-- Format the entire file
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { noremap = true })

-- Close buffer
vim.keymap.set("n", "<leader>q", "<cmd>bd<CR>", { desc = "Close Buffer" })

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("x", "<leader>p", [["_dP]])


-- Copy into clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>.", function()
  vim.cmd("so")
end)

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Navigate vim panes better
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<Alt-left>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')

-- Tab & Shift-Tab go forward and backward in the opened buffers
vim.api.nvim_set_keymap('n', '<Tab>', '<C-w><C-w>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bp<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader><left>', '5<C-W>>')
vim.keymap.set('n', '<leader><right>', '5<C-W><')

-- Ctrl-x to close current buffer
vim.api.nvim_set_keymap('n', '<C-x>', ':bd<CR>',
  { noremap = true, silent = true })

-- Ctrl s to save
vim.api.nvim_set_keymap('n', '<C-S>', ':write<CR>',
  { noremap = true, silent = true })

-- Ctrl-q to quit
vim.api.nvim_set_keymap('n', '<C-Q>', ':quit<CR>',
  { noremap = true, silent = true })
