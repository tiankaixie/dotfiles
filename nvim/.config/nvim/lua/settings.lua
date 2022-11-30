local vim = vim

vim.opt.number = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.mouse = 'a'
vim.opt.showtabline = 2
vim.opt.showmode = false
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cursorline = true
vim.opt.numberwidth = 4
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8



if vim.fn.exists("g:neovide") then
    vim.g.neovide_refresh_rate = 120
    vim.g.neovide_hide_mouse_when_typing = true
end


-- lsp config

local lsp = require "lspconfig"

