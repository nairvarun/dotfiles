vim.api.nvim_set_keymap('n', '<A-x>', ':25Lexplore<CR>', {})
vim.api.nvim_set_keymap('n', '<A-s>', '<esc>:w<CR>:source %<CR>', {})
vim.api.nvim_set_keymap('i', '<A-s>', '<esc>:w<CR>:source %<CR>', {})
vim.api.nvim_set_keymap('i', 'jk', '<esc>', {})
