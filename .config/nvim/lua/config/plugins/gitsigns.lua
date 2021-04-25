require("gitsigns").setup({
    signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "┃" },
        topdelete = { text = "┃" },
        changedelete = { text = "┃" }
    },
    keymaps = { noremap = true, buffer = true },
    sign_priority = 5
})
