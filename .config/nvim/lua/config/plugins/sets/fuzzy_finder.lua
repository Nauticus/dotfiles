return {
    {
        "junegunn/fzf.vim",
        requires = {
            { "junegunn/fzf", dir = "~/.fzf", run = "./install --all" },
        },
        config = function()
            require "config.plugins.configs.fzf"
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require "config.plugins.configs.telescope"
        end,
        requires = {
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            { "kyoh86/telescope-windows.nvim" },
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
    },
}
