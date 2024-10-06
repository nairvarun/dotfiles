require('gitsigns').setup {
	signcolumn = false,					-- Toggle with `:Gitsigns toggle_signs`
	numhl      = true,					-- Toggle with `:Gitsigns toggle_numhl`
	current_line_blame = true,			-- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text_pos = 'right_align',	-- 'eol' | 'overlay' | 'right_align'
	},
}

vim.api.nvim_set_keymap('n', '<space>g', ':Gitsigns ', {noremap=true})

