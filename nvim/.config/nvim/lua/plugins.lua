-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.cmd("packadd packer.nvim")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
    augroup packer_user_config 
    autocmd! 
    autocmd BufWritePost plugins.lua source <afile> | PackerSync 
    augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Change to popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)



return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use "nvim-lua/plenary.nvim"

  -- My plugins here
  use { 'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function() require('nvim-tree').setup ({}) end
  }

  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    event = "VimEnter",
    config = 'vim.cmd[[COQnow]]'
  }
  use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
  use { 'ms-jpq/coq.thirdparty', branch = '3p' }
  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('nvim-treesitter.configs').setup {
                highlight = {
                    enable = true
                },
            }
        end
  }
  use "p00f/nvim-ts-rainbow"
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
--  use 'akinsho/toggleterm.nvim'
  use 'voldikss/vim-floaterm'
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function() require("null-ls").setup {
        sources = {
          require("null-ls").builtins.formatting.eslint_d,
          require("null-ls").builtins.diagnostics.eslint_d,
          require("null-ls").builtins.code_actions.eslint_d,
          require("null-ls").builtins.diagnostics.flake8,
          require("null-ls").builtins.formatting.black.with { extra_args = { "--fast" } },
          require("null-ls").builtins.formatting.isort,
          --                require("null-ls").builtins.code_actions.gitsigns
        }
      }
    end,
    requires = { "nvim-lua/plenary.nvim" },
  }

  --[[
  -- Using Packer:
  use {'Mofiqul/dracula.nvim',
    config = function() require("dracula").setup({
      -- customize dracula color palette
      colors = {
        bg = "#282A36",
        fg = "#F8F8F2",
        selection = "#44475A",
        comment = "#6272A4",
        red = "#FF5555",
        orange = "#FFB86C",
        yellow = "#F1FA8C",
        green = "#50fa7b",
        purple = "#BD93F9",
        cyan = "#8BE9FD",
        pink = "#FF79C6",
        bright_red = "#FF6E6E",
        bright_green = "#69FF94",
        bright_yellow = "#FFFFA5",
        bright_blue = "#D6ACFF",
        bright_magenta = "#FF92DF",
        bright_cyan = "#A4FFFF",
        bright_white = "#FFFFFF",
        menu = "#21222C",
        visual = "#3E4452",
        gutter_fg = "#4B5263",
        nontext = "#3B4048",
      },
      -- show the '~' characters after the end of buffers
      -- show_end_of_buffer = true, -- default false
      -- use transparent background
      transparent_bg = true, -- default false
      -- set custom lualine background color
      -- lualine_bg_color = "#44475a", -- default nil
      -- set italic comment
      italic_comment = true, -- default false
      -- overrides the default highlights see `:h synIDattr`
      overrides = {
        -- Examples
        -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
        NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
        -- Nothing = {} -- clear highlight of Nothing
      },
  })
end
}
]]--
--[[
  use { 'projekt0n/github-nvim-theme',
    config = function() require('github-theme').setup({
        theme_style = "dark",
        function_style = "italic",
        sidebars = { "qf", "vista_kind", "terminal", "packer" },

        -- Change the "hint" color to the "orange" color,
        -- and make the "error" color bright red
        colors = { hint = "orange", error = "#ff0000" },


      })
    end
  }
]]--

  use {'nyoom-engineering/oxocarbon.nvim'}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
