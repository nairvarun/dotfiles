local _inDegen = false
function _G.toggleDgen()
	_inDegen = not _inDegen
	if _inDegen then
		print('-- DEGEN --')
		vim.api.nvim_set_keymap('n', '<leader>r', ':echo"yesy"<CR>', {noremap = true, silent = true})
		-- vim.api.nvim_exec([[call feedkeys("\<C-w>=")]], true)
		
		-- the next line can sleect words between 2 whitepaces. figure out some regex vodoo to get a plumer like functionality(plan9)
		vim.api.nvim_set_keymap('n', '<C-LeftMouse>', 'viW', {})
	else
		print(' ')
		print('-- NO DEGEN --')
		--vim.api.nvim_del_keymap('n', '<A-r>', ':echo"yesy"<CR>', {noremap = true, silent = true})
		vim.api.nvim_del_keymap('n', '<leader>r')
		vim.api.nvim_del_keymap('n', '<C-LeftMouse>')
	end
	return _inDegen
end

--vim.api.nvim_set_keymap('n', '<leader>d', ':lua toggleDgen()<CR>', {noremap = true, silent = true})
