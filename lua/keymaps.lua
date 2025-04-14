vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Normal mode: Ctrl+S to save
vim.keymap.set('n', '<C-s>', ':w<CR>', { silent = true })

-- Insert mode: Ctrl+S to save, then go back to insert mode
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>i', { silent = true })

-- Ctrl+Backspace deletes the previous word in insert mode
vim.keymap.set('i', '<C-H>', '<C-w>', { noremap = true })

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', { noremap = true })

-- Resize with arrows
vim.keymap.set('n', '<A-Up>', ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Down>', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })

vim.keymap.set('i', '<S-Left>', '<Esc><Left>v', { desc = 'Visual mode left', silent = true, noremap = true })
vim.keymap.set('i', '<S-Right>', '<Esc>v', { desc = 'Visual mode right', silent = true, noremap = true })
vim.keymap.set('i', '<S-Up>', '<Esc><Up>V', { desc = 'Visual mode up (line)', silent = true, noremap = true })
vim.keymap.set('i', '<S-Down>', '<Esc>V', { desc = 'Visual mode down (line)', silent = true, noremap = true })
