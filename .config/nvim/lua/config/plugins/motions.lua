return {
    { "kylechui/nvim-surround", event = "BufReadPre", config = true },
    { "tpope/vim-unimpaired", keys = { "[", "]" } },
    { "junegunn/vim-easy-align", cmd = "EasyAlign" },
    {
        "ggandor/leap.nvim",
        opts = {
            safe_labels = {},
            labels = "setonuhidrclgkjmwxbSETONUHIDRCLGKJMWXB",
        },
        config = function(_, opts)
            local leap = require("leap")
            leap.add_default_mappings()

            local function make_labels(str)
                local dict = {}
                for i = 1, #str do
                    dict[i] = str:sub(i, i)
                end
                return dict
            end

            leap.opts.safe_labels = opts.safe_labels
            leap.opts.labels = make_labels(opts.labels)
        end,
    },
    { "ggandor/flit.nvim", enabled = false },
}
