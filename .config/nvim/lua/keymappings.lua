-- set space no operation in normal mode
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', { noremap = true, silent = true})

-- map leader is set to space
vim.g.mapleader = ' '

-- highlight all searched string by leader + h
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', { noremap = true, silent = true})

-- nvim tree toggle
vim.api.nvim_set_keymap('n', '<Leader>j', '<CMD>NvimTreeToggle<CR>', { noremap = true, silent = true})

-- better window movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { silent = true})

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true})

-- replace escape
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'kj', '<ESC>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true, silent = true})

-- tab switch buffer
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', { noremap = true, silent = true})

-- Move selected line/block of text in visual mode
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv\'', { noremap = true, silent = true})

vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv\'', { noremap = true, silent = true})

-- TAB complete
-- vim.api.nvim_set_keymap('i', '<expr><TAB>', 'pumvisible() ? \"\\<C-n>\" : \"\\<TAB>\"', { noremap = true, silent = true})


