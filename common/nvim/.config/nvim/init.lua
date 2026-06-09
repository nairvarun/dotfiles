vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2

require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha, vim
})
vim.cmd.colorscheme "catppuccin-mocha"
