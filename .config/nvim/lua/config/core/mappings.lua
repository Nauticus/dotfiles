local keymap = vim.keymap

-- GLOBAL MAPPINGS
-- stylua: ignore start
keymap.set("n", "<C-s>",           "<CMD>update<CR>",                      { desc = "Update buffer" })
keymap.set("v", "<C-s>",           "<CMD>:update<CR>gv",                   { desc = "Update buffer" })
keymap.set("i", "<C-s>",           "<C-O>:update<CR>",                     { desc = "Update buffer" })

keymap.set("i", "<C-h>",           "<BS>",                                 { desc = "Backspace" })

keymap.set("n", "<A-k>",           "<CMD>resize -4<CR>",                   { desc = "- resize" })
keymap.set("n", "<A-j>",           "<CMD>resize +4<CR>",                   { desc = "+ resize" })
keymap.set("n", "<A-l>",           "<CMD>vertical resize +4<CR>",          { desc = "+ vertical resize" })
keymap.set("n", "<A-h>",           "<CMD>vertical resize -4<CR>",          { desc = "- vertical resize" })

-- UTILS (u)
keymap.set("n", "<leader>ur", "<CMD>so %<CR>",                        { desc = "Source file" })
keymap.set("n", "<leader>uy", "<CMD>redir @* | file | redir END<CR>", { desc = "Paste file info" })
keymap.set("n", "<leader>us", ":setlocal spell! spelllang=en_us<CR>", { desc = "Toggle spellchecking" })

keymap.set("v", "J",               ":m '>+1<CR>gv=gv")
keymap.set("v", "K",               ":m '<-2<CR>gv=gv")
keymap.set("n", "J",               "mzJ`z")
-- stylua: ignore end
