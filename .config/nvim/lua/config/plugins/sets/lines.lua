return {
    {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require "config.plugins.configs.lualine"
        end,
    },
    {
        "nanozuki/tabby.nvim",
        after = "kanagawa.nvim",
        config = function()
            require "config.plugins.configs.tabby"
        end,
    },
}
