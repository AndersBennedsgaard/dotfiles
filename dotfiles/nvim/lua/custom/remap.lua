vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'Open NetRW file tree' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Remove highlight from search' })

-- When highlighting text, allow to move with cursor staying in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Force the cursor to stay in the middle when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Remove Q
vim.keymap.set("n", "Q", "<Nop>")

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<M-z>', '<cmd>set wrap!<CR>', { desc = 'Toggle line wrapping' })

-- Move lines up and down
vim.keymap.set('n', '<M-j>', '<cmd>m .+1<CR>==', { desc = 'Move the current line down' })
vim.keymap.set('n', '<M-k>', '<cmd>m .-2<CR>==', { desc = 'Move the current line up' })
-- Move selected lines. For some reason, we must use ':' instead of '<cmd>'
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", { desc = 'Move the selected lines down' })
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", { desc = 'Move the selected lines up' })
