return {
    "ThePrimeagen/harpoon",
    keys = {
        {
            "[h",
            function()
                require("harpoon.ui").nav_prev()
            end,
            desc = "Previous mark (Harpoon)",
        },
        {
            "]h",
            function()
                require("harpoon.ui").nav_next()
            end,
            desc = "Next mark (Harpoon)",
        },
        {
            "<leader>hh",
            function()
                require("harpoon.ui").toggle_quick_menu()
            end,
            desc = "Toggle Harpoon UI",
        },
        {
            "<leader>ha",
            function()
                require("harpoon.mark").add_file()
            end,
            desc = "Mark file",
        },
    },
    opts = {
        menu = {
            width = 90,
            height = 20,
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}
