local wk = require("which-key")
local map = vim.api.nvim_set_keymap

-- Global mappings
map("n", "<C-s>", ":update<cr>", { noremap = true })
map("v", "<C-s>", "<esc>:update<cr>", { noremap = true })
map("i", "<C-s>", "<C-o>:update<cr>", { noremap = true })
map("i", "<C-H>", "<BS>", {})

wk.register {
    ["<A-Up>"] = { "<cmd>resize -4<CR>", "Resize -4" },
    ["<A-Down>"] = { "<cmd>resize +4<CR>", "Resize +4" },
    ["<A-Right>"] = { "<cmd>vertical resize +4<CR>", "Vertical Resize +4" },
    ["<A-Left>"] = { "<cmd>vertical resize -4<CR>", "Vertical Resize -4" },
    ["§"] = { "<CMD>NvimTreeToggle<CR>", "Nvim Tree" },
    ["-"] = { "<CMD>NvimTreeFindFile<CR>", "Find file in tree" },
    ["<leader>zm"] = { "<CMD>ZenMode<CR>", "ZenMode" },
    ["<leader><leader>"] = { "<CMD>Telescope builtin<CR>", "Telescope" }
}

local keymap_source = {
    name = "+source",
    l = { "<CMD>luafile %<CR>", "Source lua file" },
    v = { "<CMD>so %<CR>", "Source vim file" }
}

local keymap_utilities = {
    name = "+utils",
    r = keymap_source,
    y = { "<CMD>redir @* | file | redir END<CR>", "Paste file info" },
    h = { ":TSHighlightCapturesUnderCursor<CR>", "(TS) Syntax captures under cursor", silent = true },
    u = { ":UndotreeToggle<CR>", "Toggle undo tree bar" },
    s = { ":setlocal spell! spelllang=en_us<CR>", "Toggle spellchecking" }
}

wk.register(keymap_utilities, { prefix = "<leader>u" })
