-- leader ==> left alt
-- vim.api.nvim_set_keymap('', ' ', '<Nop>', {noremap = true})
vim.g.mapleader = ''	-- alt (ctrl+v alt+esc)

-- block selection ==> v
vim.api.nvim_set_keymap('n', 'v', '<C-v>', {noremap=true})

-- next/prev/omnicomp
vim.api.nvim_set_keymap('i', '<leader>n', '<C-n>', {noremap=true})
vim.api.nvim_set_keymap('i', '<leader>p', '<C-p>', {noremap=true})
vim.api.nvim_set_keymap('i', '<leader>N', '<C-x><C-o>', {noremap=true})
vim.api.nvim_set_keymap('i', '<leader>P', '<C-x><C-f>', {noremap=true})

-- tab navigation
vim.api.nvim_set_keymap('n', '<leader>L', 'gt', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>H', 'gT', {noremap=true})

-- split navigation
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', {noremap=true})

-- toggle split focus
local isFocused = false
function _G.toggleFocus()
    if (isFocused) then
        vim.api.nvim_exec([[call feedkeys("\<C-w>=")]], true)
    else
        vim.api.nvim_exec([[call feedkeys("\<C-w>|\<C-w>_")]], true)
    end
    isFocused = not isFocused
end

vim.api.nvim_set_keymap('n', '<leader>;', ':lua toggleFocus()<CR>', {noremap=true, silent=true})

