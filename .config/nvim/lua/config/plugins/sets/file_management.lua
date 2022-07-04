return {
    "tamago324/lir.nvim",
    disable = false,
    requires = {
        "nvim-lua/plenary.nvim",
        "tamago324/lir-git-status.nvim",
        "kyazdani42/nvim-web-devicons",
    },
    config = function()
        require "config.plugins.configs.lir"
    end,
}
