local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- My plugins here
  use { 'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function() require('nvim-tree').setup {} end
    }
  
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/nvim-compe'

  use {'projekt0n/github-nvim-theme',
       config = function() require('github-theme').setup({
		theme_style = "dark_default",
		  function_style = "italic",
		  sidebars = {"qf", "vista_kind", "terminal", "packer"},

		  -- Change the "hint" color to the "orange" color,
		  -- and make the "error" color bright red
		  colors = {hint = "orange", error = "#ff0000"},

		  -- Overwrite the highlight groups
		  overrides = function(c)
		    return {
		      htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
		      DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
		      -- this will remove the highlight groups
		      TSField = {},
		    }
		  end


       }) end
    }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)


