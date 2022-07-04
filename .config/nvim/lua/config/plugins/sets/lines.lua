return {
    "diegodox/lualine.nvim",
    after = "nvim-lightbulb",
    disable = false,
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
        require "config.plugins.configs.lualine"
    end,
}
