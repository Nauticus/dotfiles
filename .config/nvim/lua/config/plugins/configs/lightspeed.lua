vim.cmd [[autocmd User LightspeedLeave set scrolloff=4]]
local opts = require("lightspeed").opts

table.remove(opts.safe_labels, 1)
table.remove(opts.labels, 1)

require("lightspeed").setup {
    force_beacons_into_match_width = true,
    match_only_the_start_of_same_char_seqs = true,
    ignore_case = true,
}
