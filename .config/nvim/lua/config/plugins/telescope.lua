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
            "--trim",
            "--glob",
            "!**/{.git,node_modules}",
        },
        initial_mode = "insert",
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_ignore_patterns = file_ignore_patterns,
        layout_strategy = "vertical",
        layout_config = { preview_cutoff = 10, mirror = false },
        mappings = {
            i = {
                ["<C-w>"] = function()
                    vim.cmd [[normal! bce]]
                end,
            },
        },
    },
    pickers = {
        builtin = {
            include_extensions = true,
        },
        oldfiles = {
            only_cwd = true,
        },
        find_files = {
            find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
        },
        live_grep = {
            disable_coordinates = true,
        },
    },
    extensions = {
        -- file_browser = {
        --     theme = "ivy",
        -- },
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
require("telescope").load_extension "windows"
require("telescope").load_extension "file_browser"

telescope_mappings()
