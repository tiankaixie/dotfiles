lvim.leader = "space"

-- ctrl-s to save
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- replace escape
lvim.keys.insert_mode["jk"] = "<ESC>"
lvim.keys.insert_mode["kj"] = "<ESC>"
lvim.keys.normal_mode['<leader>j'] = ":Telescope live_grep<cr>"
