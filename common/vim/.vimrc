" settings
syntax on
filetype plugin indent on

"set number
set path+=**												" for recursive file search
set number
set relativenumber
set nowrap
set tabstop=2
set shiftwidth=2
set ignorecase
set incsearch
set smartcase
set hlsearch
set ruler
" set undofile
set wildmenu


" keymaps
" let mapleader = ""										" ^[ == Alt/Meta. typed by going Ctrl+v + Alt<esc>
xnoremap <silent> <C-@> :w !wl-copy<CR><CR>
nnoremap v <C-v>
" inoremap <leader>n <C-n>
" inoremap <leader>p <C-p>
" 
" nnoremap <leader>j <C-w>j
" nnoremap <leader>k <C-w>k
" nnoremap <leader>h <C-w>h
" nnoremap <leader>l <C-w>l
" let s:isFscrn = 0
" function! ToggleFscrn()
" 	if s:isFscrn
" 		call feedkeys("\<C-w>=")
" 		let s:isFscrn = 0
" 	else
" 		call feedkeys("\<C-w>|\<C-w>_")
" 		let s:isFscrn = 1
" 	endif
" endfunction
" nnoremap <silent> <leader>; :call ToggleFscrn()<CR>
" 
" nnoremap <leader>L gt
" nnoremap <leader>H gT
 
" automatically source ~/.vimrc on :w
augroup vimrc
	autocmd!
	autocmd BufWritePost ~/.vimrc source ~/.vimrc
augroup end

