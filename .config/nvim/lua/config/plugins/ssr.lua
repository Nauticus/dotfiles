return {
    "cshuaimin/ssr.nvim",
    name = "ssr",
    keys = {
        {
            "<leader>tr",
            function()
                require("ssr").open()
            end,
            mode = { "n", "v" },
            desc = "Open structural search and replace"
        }
    },
    config = function()
        require("ssr").setup()
    end,
}
