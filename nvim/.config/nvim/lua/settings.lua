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
vim.opt.termguicolors = true
vim.o.background = "dark" -- triggers dark colorscheme



if vim.fn.exists("g:neovide") then
    vim.g.neovide_refresh_rate = 120
    -- vim.g.neovide_scale_factor = 1.2
    -- vim.g.neovide_transparency = 0.9
    -- vim.g.transparency = 0.9
    vim.g.neovide_fullscreen = true
    vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h12"
    -- vim.g.neovide_floating_blur_amount_x = 4.0
    -- vim.g.neovide_floating_blur_amount_y = 4.0
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_cursor_vfx_mode = "railgun"
end


-- vim.cmd([[colorscheme dracula]])
vim.cmd("colorscheme oxocarbon")
