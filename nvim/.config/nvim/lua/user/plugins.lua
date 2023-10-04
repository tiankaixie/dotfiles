local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'tiankaixie/fui.nvim'
  use 'tiankaixie/lualine.nvim'         -- Statusline
  use 'onsails/lspkind-nvim'            -- vscode-like pictograms
  use 'glepnir/lspsaga.nvim'            -- LSP UIs
  use 'kyazdani42/nvim-web-devicons'    -- File icons
  use 'akinsho/nvim-bufferline.lua'     -- Bufferline on the top
  use 'rktjmp/lush.nvim'                -- Customizable colorschemes
  use 'lewis6991/gitsigns.nvim'         -- git timeline & blame

  use 'nvim-lua/plenary.nvim'           -- Common utilities
  use 'hrsh7th/cmp-buffer'              -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp'            -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp'                -- Completion
  use 'neovim/nvim-lspconfig'           -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  use 'L3MON4D3/LuaSnip'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use { 'numToStr/Comment.nvim',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    }
  }
  use 'norcalli/nvim-colorizer.lua'
  use 'github/copilot.vim'
end)
