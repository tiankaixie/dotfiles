-- set space no operation in normal mode
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', { noremap = true, silent = true})


-- aa
-- bb
-- cc

-- map leader is set to space
vim.g.mapleader = ' '

-- highlight all searched string by leader + h
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', { noremap = true, silent = true})

-- nvim tree toggle
vim.api.nvim_set_keymap('n', '<Leader>j', '<CMD>NvimTreeToggle<CR>', { noremap = true, silent = true})

-- better window movement
vim.api.nvim_set_keymap('n', '<S-h>', '<C-w>h', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-l>', '<C-w>l', { noremap = true, silent = true})

-- resize with arrows
vim.api.nvim_set_keymap('n', '<S-Down>', ':resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Up>', ':resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Right>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Left>', ':vertical resize +2<CR>', { noremap = true, silent = true })

-- nevigate buffers
-- vim.api.nvim_set_keymap('n', '<S-l>', ':bnext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-h>', ':bprevious<CR>', { noremap = true, silent = true })

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true})

-- move text up and down (not working 
vim.api.nvim_set_keymap('v', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true})

-- better paste
vim.api.nvim_set_keymap('v', 'p', '"_dP', { noremap = true, silent = true})


-- replace escape
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'kj', '<ESC>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true, silent = true})

-- tab switch buffer
-- vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', { noremap = true, silent = true})

-- Move selected line/block of text in visual mode
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv\'', { noremap = true, silent = true})

vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv\'', { noremap = true, silent = true})

-- TAB complete
-- vim.api.nvim_set_keymap('i', '<expr><TAB>', 'pumvisible() ? \"\\<C-n>\" : \"\\<TAB>\"', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>FloatermToggle<cr>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<leader>t', '<cmd>FloatermToggle<cr>', { noremap = true, silent = true})



