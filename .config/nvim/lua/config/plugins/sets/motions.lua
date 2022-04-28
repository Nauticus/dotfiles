return {
    "tpope/vim-surround",
    "tpope/vim-unimpaired",
    "junegunn/vim-easy-align",
    {
        "ggandor/lightspeed.nvim",
        config = function()
            require "config.plugins.configs.lightspeed"
        end,
    },
}
