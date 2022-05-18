---- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = vim.api.nvim_create_augroup("yankHighlight", { clear = true }),
})

