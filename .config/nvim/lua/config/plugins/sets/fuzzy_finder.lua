return {
    { "junegunn/fzf", dir = "~/.fzf", run = "./install --all" },
    {
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            { "kyoh86/telescope-windows.nvim" },
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-ui-select.nvim" },
            { "nvim-telescope/telescope-packer.nvim" },
            { "benfowler/telescope-luasnip.nvim" },
        },
    },
}
