------ leader ==> alt
-- vim.api.nvim_set_keymap('', '', '<Nop>', {noremap = true})         -- if <alt> is set to <Nop> Alt+{x} wont sent the escape signal in any terminal
vim.g.mapleader = ''                                                  -- `^[`(alt) typed by `ctrl+v alt+esc`

------ esc
-- vim.api.nvim_set_keymap('!', '<leader>i', '<esc>', {noremap=true})

------ block selection ==> v
-- `v` toggles between block visual and then visual
vim.api.nvim_set_keymap('n', 'v', '<C-v>', {noremap=true})

-- ------ leader+w ==> save
-- vim.api.nvim_set_keymap('n', '<leader>w', '<esc>:w<CR>', {noremap=true})
-- vim.api.nvim_set_keymap('i', '<leader>w', '<esc>:w<CR>', {noremap=true})

------ $ ==> <leader>e
vim.api.nvim_set_keymap('n', '<leader>e', '$', {noremap=true})
vim.api.nvim_set_keymap('x', '<leader>e', '$', {noremap=true})
vim.api.nvim_set_keymap('o', '<leader>e', '$', {noremap=true})

------ % ==> <leader>p
---- noremap is false so that html tags work
vim.api.nvim_set_keymap('n', '<leader>p', '%', {noremap=false})
vim.api.nvim_set_keymap('x', '<leader>p', '%', {noremap=false})

------ next, prev, path completion, omnicomplition
-- vim.api.nvim_set_keymap('i', '<leader>j', '<C-n>', {noremap=true})
-- vim.api.nvim_set_keymap('i', '<leader>k', '<C-p>', {noremap=true})
-- vim.api.nvim_set_keymap('i', '<leader>n', '<C-x><C-o>', {noremap=true})
-- vim.api.nvim_set_keymap('i', '<leader>m', '<C-x><C-f>', {noremap=true})

-- buffer navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<cmd>lua toggleQfl()<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>j', '<cmd>bn<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>bp<CR>', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<Tab>', ':b ', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<S-Tab>', ':find ', {noremap=true})

------ tab navigation
-- vim.api.nvim_set_keymap('n', '<leader>l', 'gt', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<leader>h', 'gT', {noremap=true})

------ split navigation
-- vim.api.nvim_set_keymap('n', '<leader>a', '<C-w>h', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<leader>s', '<C-w>j', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<leader>w', '<C-w>k', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<leader>d', '<C-w>l', {noremap=true})

------ toggle split focus
-- local isFocused = false
-- function toggleFocus()
--     if (isFocused) then
--         vim.api.nvim_exec([[call feedkeys("\<C-w>=")]], true)
--     else
--         vim.api.nvim_exec([[call feedkeys("\<C-w>|\<C-w>_")]], true)
--     end
--     isFocused = not isFocused
-- end
-- vim.api.nvim_set_keymap('n', '<leader>;', '<cmd>lua toggleFocus()<CR>', {noremap=true, silent=true})

------ quickfix list keybindings
-- :cnext
vim.api.nvim_set_keymap('n', '<C-j>', '<cmd>cnext<CR>', {noremap=true})
-- :cprev
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>cprev<CR>', {noremap=true})
-- -- :copen
-- vim.api.nvim_set_keymap('n', '<C-h>', '<cmd>copen<CR>', {noremap=true})
-- -- :cclose
-- vim.api.nvim_set_keymap('n', '<C-l>', '<cmd>cclose<CR>', {noremap=true})
------ toggle quickfix list
local qflOpen = false
function toggleQfl()
    if (qflOpen) then
		vim.cmd('copen')
    else
		vim.cmd('cclose')
    end
    qflOpen = not qflOpen
end
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua toggleQfl()<CR>', {noremap=true, silent=true})


------ :noh ==> <leader>/
vim.api.nvim_set_keymap('n', '<leader>/', '<cmd>noh<CR>', {noremap=true})

------ Lexplore
-- vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>Lexplore 20<CR>', {noremap=true})

------ run whatever is in * register in command mode
-- vim.api.nvim_set_keymap('x', '<leader>r', 'y<esc>:<C-r>*<CR>', {noremap=true})

