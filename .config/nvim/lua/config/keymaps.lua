local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Better Escape
keymap.set("i", "jk", "<Esc>")
keymap.set("i", "jj", "<Esc>")

-- Fast save and quit
keymap.set("n", "<Leader>w", ":write!<CR>", opts)
keymap.set("n", "<Leader>q", ":q!<CR>", opts)
