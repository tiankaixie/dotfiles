-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  require "coq".lsp_ensure_capabilities {}

end


require('lspconfig')['pyright'].setup {
  on_attach = on_attach,
}
require('lspconfig')['tsserver'].setup {
  on_attach = on_attach,
}

require('lspconfig')['sumneko_lua'].setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

--require'nvim-treesitter.configs'.setup {
 -- highlight = {
 --   enable = true
 -- }
--}

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"

  -- My plugins here
  use { 'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function() require('nvim-tree').setup {} end
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
        run = function() 
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    }

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

  use { 'projekt0n/github-nvim-theme',
    config = function() require('github-theme').setup({
        theme_style = "dark_default",
        function_style = "italic",
        sidebars = { "qf", "vista_kind", "terminal", "packer" },

        -- Change the "hint" color to the "orange" color,
        -- and make the "error" color bright red
        colors = { hint = "orange", error = "#ff0000" },

        -- Overwrite the highlight groups
        --overrides = function(c)
        --  return {
         --   htmlTag = { fg = c.red, bg = "#282c34", sp = c.hint, style = "underline" },
         --   DiagnosticHint = { link = "LspDiagnosticsDefaultHint" },
            -- this will remove the highlight groups
          --  TSField = {},
         -- }
        --end


      })
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
