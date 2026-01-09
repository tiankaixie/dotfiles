return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      -- Nerv theme colors
      local colors = {
        bg = "#0a1612",
        bg_elevated = "#0f1f1a",
        bg_highlight = "#1a2e28",
        fg = "#8fb3a5",
        fg_bright = "#a8d3c5",
        fg_muted = "#5a7a6d",
        accent = "#e85d04",
        accent_hover = "#f4820b",
        border = "#2a4a3d",
        git_add = "#4a8c5c",
        git_change = "#d4a017",
        git_delete = "#c92a2a",
        error = "#c92a2a",
        warning = "#d4a017",
        info = "#3a7a8c",
      }

      -- Custom nerv theme for lualine
      local nerv_theme = {
        normal = {
          a = { bg = colors.accent, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg_elevated, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg_muted },
        },
        insert = {
          a = { bg = colors.git_add, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg_elevated, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg_muted },
        },
        visual = {
          a = { bg = colors.info, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg_elevated, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg_muted },
        },
        replace = {
          a = { bg = colors.error, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg_elevated, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg_muted },
        },
        command = {
          a = { bg = colors.warning, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg_elevated, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg_muted },
        },
        inactive = {
          a = { bg = colors.bg_elevated, fg = colors.fg_muted },
          b = { bg = colors.bg, fg = colors.fg_muted },
          c = { bg = colors.bg, fg = colors.fg_muted },
        },
      }

      return {
        options = {
          theme = nerv_theme,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " ",
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1 },
          },
          lualine_x = {
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " ",
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}
