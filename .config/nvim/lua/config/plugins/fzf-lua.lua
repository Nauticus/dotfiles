local wk = require "which-key"
local fzf = require "fzf-lua"

fzf.setup {
    winopts = {
        height = 0.95,
        width = 0.85,
        preview = { layout = "vertical", vertical = "up:40%" },
    },
    fzf_opts = { ["--layout"] = "default" },
}

wk.register({
    f = { fzf.files, "Search files" },
    w = { fzf.grep_cword, "Search word" },
    h = { fzf.oldfiles, "Search oldfiles" },
    p = { fzf.grep_project, "Grep Project" },
    r = { fzf.live_grep, "Live grep" },
    t = { fzf.tabs, "Search tabs" },
    l = { fzf.lines, "Search Lines" },
}, { prefix = "<leader>f" })

wk.register(
    { w = { fzf.grep_visual, "Grep visual selection" } },
    { prefix = "<leader>f", mode = "v" }
)
