-- set space no operation in normal mode
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', { noremap = true, silent = true})

-- map leader is set to space
vim.g.mapleader = ' '

-- highlight all searched string by leader + h
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', { noremap = true, silent = true})

-- nvim tree toggle
vim.api.nvim_set_keymap('n', '<Leader>j', '<CMD>NvimTreeToggle<CR>', { noremap = true, silent = true})

