------ for tmux (https://github.com/jpalardy/vim-slime#tmux)
-- ":"       means current window, current pane (a reasonable default)
-- ":i"      means the ith window, current pane
-- ":i.j"    means the ith window, jth pane
-- "h:i.j"   means the tmux session where h is the session identifier
--           (either session name or number), the ith window and the jth pane
-- "%i"      means i refers the pane's unique id	[echo $TMUX_PANE]
-- "{token}" one of tmux's supported special tokens, like "{last}"

-- config
vim.g.slime_target='tmux'
vim.g.slime_default_config={socket_name = "default", target_pane = "{last}"}

-- keymaps
vim.api.nvim_set_keymap('n', '<leader>s', 'V<Plug>SlimeRegionSend', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>S', 'V<Plug>SlimeParagraphSend', {noremap=true})
vim.api.nvim_set_keymap('x', '<leader>s', 'V<Plug>SlimeRegionSend', {noremap=true})
vim.api.nvim_set_keymap('x', '<leader>S', '<Plug>SlimeRegionSend', {noremap=true})

