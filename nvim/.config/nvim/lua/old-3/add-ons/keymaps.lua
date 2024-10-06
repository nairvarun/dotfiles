--region minimap
vim.api.nvim_set_keymap('n', '<leader>m', ':MinimapToggle<CR>:MinimapRefresh<CR><C-w>l', {noremap = true})
--endregion

--region markdown preview
vim.api.nvim_set_keymap('n', '<leader>p', ':MarkdownPreviewToggle<CR><C-w>l', {noremap = true})
--endregion
