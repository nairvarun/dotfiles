local colorscheme = 'tokyonight'
if not pcall(vim.cmd, 'colorscheme ' .. colorscheme) then
	vim.notify('failed to set colorscheme')
end

