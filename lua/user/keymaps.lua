--keys remaining{{{
--
-- leader: 	qweryuiopadfgjklzcvbxn
-- alt: 	wasdqertyuiopfgzcbnm 
--
--}}}


-- <leader> ==> spacebar{{{
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', {noremap = true})
vim.g.mapleader = ' '
--}}}

-- vanilla vim maps{{{

-- jk ==> <esc>{{{
vim.api.nvim_set_keymap('i', 'kj', '<esc>', {noremap = true})
vim.api.nvim_set_keymap('v', 'kj', '<esc>', {noremap = true})
vim.api.nvim_set_keymap('i', 'jk', '<esc>', {noremap = true})
vim.api.nvim_set_keymap('v', 'jk', '<esc>', {noremap = true})
vim.api.nvim_set_keymap('c', 'jk', '<C-u><bs>', {noremap = true})
vim.api.nvim_set_keymap('c', 'jk', '<C-u><bs>', {noremap = true})
--}}}

-- visual block workaround for windows terminal{{{
vim.api.nvim_set_keymap('n', 'vf', '<C-v>', {noremap = true})
--}}}

-- wrap X around text{{{
-- vim.api.nvim_set_keymap('v', '<A-(>', 'c()<esc>P', {noremap = true})
-- vim.api.nvim_set_keymap('v', '<A-[>', 'c[]<esc>P', {noremap = true})
-- vim.api.nvim_set_keymap('v', '<A-{>', 'c{}<esc>P', {noremap = true})
-- vim.api.nvim_set_keymap('v', '<A-<>', 'c<><esc>P', {noremap = true})
-- vim.api.nvim_set_keymap('v', '<A-">', 'c""<esc>P', {noremap = true})
-- vim.api.nvim_set_keymap('v', '<A-\'>', 'c\'\'<esc>P', {noremap = true})
--}}}

-- open vim file explorer{{{
vim.api.nvim_set_keymap('n', '<A-x>', ':25Lexplore<CR>', {noremap = true})
--}}}

-- move lines up and down{{{
vim.api.nvim_set_keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", {noremap = true})
vim.api.nvim_set_keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", {noremap = true})
--}}}

-- buffers, windows & tabs{{{

-- naigate buffers
vim.api.nvim_set_keymap('n', '<A-b>', ':<C-U>buffers!<CR>:execute ":buffer " . nr2char(getchar())<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-e>', ':<C-U>buffers<CR>:<C-U>e ', {noremap = true})

-- common buffer commands
vim.api.nvim_set_keymap('n', '<A-.>', ':split ', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-,>', ':vsplit ', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-w>', '<C-w>K', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-s>', '<C-w>J', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-a>', '<C-w>H', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-d>', '<C-w>L', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-->', '<C-w>_', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-\\>', '<C-w>|', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-=>', '<C-w>=', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<A-;>', '<C-w>|<C-w>_', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-;>', ':lua fScrn()<CR>', {noremap = true})
local isFScrn = false
function _G.fScrn()
	if (isFScrn) then
		vim.api.nvim_exec([[call feedkeys("\<C-w>=")]], true)
	else
		vim.api.nvim_exec([[call feedkeys("\<C-w>|\<C-w>_")]], true)
	end
	isFScrn = not isFScrn
end

-- resize windows
vim.api.nvim_set_keymap('n', '<A-Up>', ':resize -2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-Down>', ':resize +2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-Left>', ':vertical resize -2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-Right>', ':vertical resize +2<CR>', {noremap = true})

-- navigate tabs
-- vim.api.nvim_set_keymap('n', '<S-Tab>', ':<C-U>tabs<CR>:execute "normal" . nr2char(getchar()) . "gt"<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Tab>', ':execute "normal" . nr2char(getchar()) . "gt"<CR>', {noremap = true})

-- common tab commands
vim.api.nvim_set_keymap('n', '<A-t>', ':tabnew<CR>', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<leader>f', ':tab drop ', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<leader>l', ':tabnext<CR>', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<leader>h', ':tabprevious<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-m>', '<C-w>T', {noremap = true})
--}}}

-- clear search highlights{{{
vim.api.nvim_set_keymap('n', '<A-/>', ':noh<CR>', {noremap = true})
--}}}

--}}}

-- extension maps {{{

-- minimap{{{
vim.api.nvim_set_keymap('n', '<leader>m', ':MinimapToggle<CR>:MinimapRefresh<CR><C-w>l', {noremap = true})
--}}}
     
--}}}
