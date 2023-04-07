return {
    -- Docs
    { "nanotee/luv-vimdocs", event = "VeryLazy" },
    { "milisims/nvim-luaref", event = "VeryLazy" },
    { "Asheq/close-buffers.vim", cmd = "Bdelete" },

    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        keys = {
            { "<leader>uu", ":UndotreeToggle<CR>", desc = "Toggle UndoTree" },
        },
    },
    {
        "norcalli/nvim-colorizer.lua",
        cmd = { "ColorizerToggle", "ColorizerAttachToBuffer" },
        opts = {
            scss = { rgb_fn = true },
            css = { rgb_fn = true },
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = "markdown",
    },
    -- {
    --     "aserowy/tmux.nvim",
    --     keys = {
    --         "<C-l>",
    --         "<C-h>",
    --         "<C-j>",
    --         "<C-k>",
    --     },
    --     opts = {
    --         copy_sync = { enable = false },
    --     },
    --     config = true
    -- },
    {
        "numToStr/Navigator.nvim",
        keys = {
            { "<C-h>", "<cmd>NavigatorLeft<CR>", desc = "Navigate Left" },
            { "<C-j>", "<cmd>NavigatorDown<CR>", desc = "Navigate Down" },
            { "<C-k>", "<cmd>NavigatorUp<CR>", desc = "Navigate Up" },
            { "<C-l>", "<cmd>NavigatorRight<CR>", desc = "Navigate Right" },
        },
        config = true,
    },
    {
        "anuvyklack/pretty-fold.nvim",
        config = true,
    },
    {
        "numToStr/Comment.nvim",
        keys = { "gc", "gb", { "gc", mode = "v" }, { "gb", mode = "v" } },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            padding = true,
        },
        config = true,
    },
    {
        "zbirenbaum/neodim",
        event = "LspAttach",
        config = true,
    },
    { "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
}
