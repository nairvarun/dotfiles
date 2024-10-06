local colorscheme = 'tokyonight'
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme )
if not status_ok then
	vim.notify('failed to set colorscheme. [**/nvim/lua/user/add-ons/colorscheme.lua]')
	return
end

