local telescope = require "telescope"
local telescope_mappings = require("config.mappings").telescope_mappings

local file_ignore_patterns = { ".git/.*", "node_modules/.*" }

telescope.setup {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob",
            "!**/{.git,node_modules}",
        },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_ignore_patterns = file_ignore_patterns,
        layout_strategy = "vertical",
        layout_config = { preview_cutoff = 10, mirror = false },
        mappings = { i = { ["<C-h>"] = "which_key" } },
    },
    pickers = {
        builtin = { include_extensions = true },
        find_files = { find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" } },
    },
    extensions = {
        file_browser = { theme = "ivy" },
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
}

require("telescope").load_extension "fzf"

telescope_mappings()
