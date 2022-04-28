return {
    "lewis6991/impatient.nvim",
    "Asheq/close-buffers.vim",
    "gpanders/editorconfig.nvim",
    { "mbbill/undotree", opt = true, cmd = "UndotreeToggle" },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup { scss = { rgb_fn = true }, css = { rgb_fn = true } }
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = { "markdown" },
    },
    {
        "folke/which-key.nvim",
        config = function()
            require "config.plugins.configs.which-key"
        end,
    },
    {
        "anuvyklack/pretty-fold.nvim",
        config = function()
            require("pretty-fold").setup {}
            require("pretty-fold.preview").setup_keybinding()
        end,
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup { stages = "static" }
            vim.notify = require "notify"
        end,
    },
    {
        "aserowy/tmux.nvim",
        config = function()
            require("tmux.init").setup { navigation = { enable_default_keybindings = true } }
        end,
    },
}
