return {
    "tpope/vim-surround",
    "tpope/vim-unimpaired",
    "junegunn/vim-easy-align",
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").set_default_keymaps()
        end,
    },
    {
        "ggandor/lightspeed.nvim",
        disable = true,
        config = function()
            require "config.plugins.configs.lightspeed"
        end,
    },
    {
        "phaazon/hop.nvim",
        disable = true,
        config = function()
            local hop = require "hop"
            local hop_hint = require "hop.hint"

            require("hop").setup {
                keys = "sfdajlkuiopqwerty",
            }

            vim.keymap.set("n", "s", function()
                hop.hint_char2 {
                    direction = hop_hint.HintDirection.AFTER_CURSOR,
                    current_line_only = false,
                }
            end, { desc = "Serach lines" })

            vim.keymap.set("n", "S", function()
                hop.hint_char2 {
                    direction = hop_hint.HintDirection.BEFORE_CURSOR,
                    current_line_only = false,
                }
            end)
        end,
    },
}
