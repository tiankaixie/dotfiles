local colorscheme = "oxocarbon"
-- local colorscheme = "tokyonight"


local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

require("transparent").setup({
  groups = { -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLineNr', 'EndOfBuffer',
  },
  extra_groups = { -- table/string: additional groups that should be cleared
    -- In particular, when you set it to 'all', that means all available groups

    -- example of akinsho/nvim-bufferline.lua
    -- "BufferLineTabClose",
    -- "BufferlineBufferSelected",
    -- "BufferLineFill",
    -- "BufferLineBackground",
    -- "BufferLineSeparator",
    -- "BufferLineIndicatorSelected",
    "NvimTreeNormal"
  },
  exclude_groups = {}, -- table: groups you don't want to clear
})

-- require("transparent").setup({
--   
--   enable = true, -- boolean: enable transparent
--   extra_groups = { -- table/string: additional groups that should be cleared
--     -- In particular, when you set it to 'all', that means all available groups
--
--     -- example of akinsho/nvim-bufferline.lua
--     -- "BufferLineTabClose",
--     -- "BufferlineBufferSelected",
--     -- "BufferLineFill",
--     -- "BufferLineBackground",
--     -- "BufferLineSeparator",
--     -- "BufferLineIndicatorSelected",
--     "NvimTreeNormal"
--   },
--   exclude = {}, -- table: groups you don't want to clear
--   ignore_linked_group = true, -- boolean: don't clear a group that links to another group
-- })
