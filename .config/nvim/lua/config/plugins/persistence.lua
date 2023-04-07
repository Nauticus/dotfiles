return {
    "folke/persistence.nvim",
    event = "BufReadPre",
    keys = {
        {
            "<leader>pl",
            function()
                require("persistence").load({ last = true })
            end,
            desc = "Restore last session.",
        },
        {
            "<leader>pr",
            function()
                require("persistence").load()
            end,
            desc = "Restore the session for the current directory.",
        },
        {
            "<leader>ps",
            function()
                require("persistence").stop()
            end,
            desc = "Stop persisting session.",
        },
        {
            "<leader>pc",
            function()
                require("persistence").start()
            end,
            desc = "Start persisting session.",
        },
    },
    config = true,
}
