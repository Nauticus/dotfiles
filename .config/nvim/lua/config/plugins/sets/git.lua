return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require "config.plugins.configs.gitsigns"
        end,
        requires = { "nvim-lua/plenary.nvim" },
    },
    {
        "tpope/vim-fugitive",
    },
}
