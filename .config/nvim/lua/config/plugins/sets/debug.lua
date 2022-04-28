return {
    "rcarriga/nvim-dap-ui",
    config = function()
        require("dapui").setup()
    end,
    requires = {
        "mfussenegger/nvim-dap",
        config = function()
            require "config.plugins.configs.dap"
        end,
    },
}
