------ :h vim.cmd
vim.cmd('syntax off')
vim.cmd('filetype plugin indent on')

------ :help options
----> misc
vim.opt.mouse			= 'a'				-- enable use of mouse
vim.opt.clipboard		= 'unnamedplus'		-- share system clipboard
vim.opt.visualbell		= true				-- visual alert
vim.opt.termguicolors	= true				-- gui colours in the terminal is supported
vim.opt.undofile		= true				-- gui colours in the terminal is supported
vim.opt.path:append('**')					-- fuzzy file finding (`:find`)

----> tabs & space
vim.opt.tabstop			= 4					-- value of `\t`
vim.opt.shiftwidth		= 4					-- value of 1 level of indentation (eg: `>>` in vim)
vim.opt.expandtab		= false				-- convert `\t` into spaces. :%retab! to convert existing tabs to spaces

----> line number
vim.opt.number			= true				-- show linenumber
vim.opt.relativenumber	= true				-- show line number relative to current line
vim.opt.signcolumn		= 'number'			-- replaces line number with lsp err symbol

----> search
vim.opt.hlsearch		= true				-- highlight words that match during search
vim.opt.ignorecase		= true				-- case insensitive search
vim.opt.smartcase		= true				-- case sensitive search only of uppercase is used
vim.opt.showmatch		= true				-- indicate matching bracket

----> buffer
vim.opt.splitbelow		= true				-- always open vertical split on the bottom half
vim.opt.splitright		= true				-- always open horizontal split on the right half
vim.opt.scrolloff		= 5					-- start scrolling when the cursor is on the 5th last line
vim.opt.sidescrolloff	= 5					-- start scrolling horizontallu when the cursor is on the 5th last character on a line
vim.opt.wrap			= false				-- disable word wrap
vim.opt.completeopt:remove('preview')		-- disable scratch buffer for lsp omnicompletion

----> whitespace
vim.opt.list			= false				-- show whitespace
vim.opt.listchars:append({					-- :h listchars
	eol = "↵",
	tab = "⋅⋅|",
	space = "⋅",
	multispace = "⋅",
	lead = "⋅",
	trail = "⋅",
	extends = ">",
	conceal = "☢",
	precedes = "<",
	nbsp = "&",
})

