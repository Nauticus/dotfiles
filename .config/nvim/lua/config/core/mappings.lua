local keymap = vim.keymap

-- GLOBAL MAPPINGS
-- stylua: ignore start
keymap.set("n", "<C-s>",           "<CMD>update<CR>",                      { desc = "Update buffer" })
keymap.set("v", "<C-s>",           "<CMD>:update<CR>gv",                   { desc = "Update buffer" })
keymap.set("i", "<C-s>",           "<C-O>:update<CR>",                     { desc = "Update buffer" })

keymap.set("i", "<C-h>",           "<BS>",                                 { desc = "Backspace" })

keymap.set("n", "<A-Up>",          "<CMD>resize -4<CR>",                   { desc = "- resize" })
keymap.set("n", "<A-Down>",        "<CMD>resize +4<CR>",                   { desc = "+ resize" })
keymap.set("n", "<A-Right>",       "<CMD>vertical resize +4<CR>",          { desc = "+ vertical resize" })
keymap.set("n", "<A-Left>",        "<CMD>vertical resize -4<CR>",          { desc = "- vertical resize" })

-- UTILS (u)
keymap.set("n", "<localleader>ur", "<CMD>so %<CR>",                        { desc = "Source file" })
keymap.set("n", "<localleader>uy", "<CMD>redir @* | file | redir END<CR>", { desc = "Paste file info" })
keymap.set("n", "<localleader>us", ":setlocal spell! spelllang=en_us<CR>", { desc = "Toggle spellchecking" })
-- stylua: ignore end
