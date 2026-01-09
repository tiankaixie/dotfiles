return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = false },
        keywords = { bold = true },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      sidebars = { "qf", "help" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,
    },
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        styles = {
          keywords = "bold",
          types = "italic,bold",
          variables = "bold",
        },
      },
    },
  },
  {
    "wongmjane/nerv-theme",
    lazy = false,
    priority = 1000,
    build = function()
      -- Create symlink from neovim-theme/colors to colors at plugin root
      local plugin_root = vim.fn.stdpath("data") .. "/lazy/nerv-theme"
      local colors_link = plugin_root .. "/colors"
      local colors_target = plugin_root .. "/neovim-theme/colors"

      -- Remove existing symlink or directory if it exists
      if vim.fn.isdirectory(colors_link) == 1 or vim.fn.filereadable(colors_link) == 1 then
        vim.fn.delete(colors_link, "rf")
      end

      -- Create symlink
      vim.fn.system(string.format("ln -s %s %s", vim.fn.shellescape(colors_target), vim.fn.shellescape(colors_link)))
    end,
    config = function()
      -- Load the colorscheme after the plugin is fully loaded
      pcall(vim.cmd.colorscheme, "nerv")
    end,
  },
}
