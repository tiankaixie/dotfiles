lvim.format_on_save.enabled = true
lvim.transparent_window = false
lvim.use_icons = true
vim.opt.guifont = "monospace:h12"

lvim.leader = "space"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- replace escape
lvim.keys.insert_mode["jk"] = "<ESC>"
lvim.keys.insert_mode["kj"] = "<ESC>"
lvim.keys.normal_mode['<leader>j'] = ":Telescope live_grep<cr>"


lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.lualine.style = "lvim"
-- if you don't want all the parsers change this to a table of the ones you want

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "markdown"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true



-- generic LSP settings

-- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  "sumneko_lua",
  "jsonls",
}

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--line-width", "80" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
}

-- Additional Plugins
lvim.plugins = {
  { 'Shatur/neovim-ayu' },
  -- { 'projekt0n/github-nvim-theme' },
  -- { 'williamboman/nvim-lsp-installer' },
  -- { 'nyoom-engineering/oxocarbon.nvim' },
}
vim.opt.wrap = true


-- neovide config
if vim.fn.exists("g:neovide") then
  vim.g.neovide_refresh_rate = 120
  -- vim.g.neovide_scale_factor = 1.2
  -- vim.g.neovide_transparency = 0.9
  -- vim.g.transparency = 0.9
  vim.g.neovide_fullscreen = true
  vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h14"
  -- vim.g.neovide_floating_blur_amount_x = 4.0
  -- vim.g.neovide_floating_blur_amount_y = 4.0
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_vfx_mode = "railgun"
end
