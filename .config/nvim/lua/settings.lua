local vim = vim

vim.opt.number = true
vim.opt.wrap = true


if vim.fn.exists("g:neovide") then
    vim.g.neovide_refresh_rate = 120
    vim.g.neovide_hide_mouse_when_typing = true
end


-- lsp config

local lsp = require "lspconfig"

