local wk = require("which-key")
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local telescope_actions = require("telescope.actions")

local M = {}

M.ignore_pattern = { ".git/.*", "node_modules/.*" }
M.file_cmd = { "fd", "--hidden", "--follow", "--type", "f", "." }

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
            "!**/{.git,node_modules}"
        },
        set_env = { ["COLORTERM"] = "truecolor" },
        file_ignore_patterns = M.ignore_pattern,
        layout_strategy = "vertical",
        layout_config = { preview_cutoff = 10, mirror = false }
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }

}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")

M.find_dotfiles = function()
    telescope_builtin.fd { cwd = "~/code/dotfiles", hidden = true }
end

M.find_in_std_path = function()
    telescope_builtin.fd { cwd = vim.fn.stdpath("data"), hidden = true }
end

M.find_files = function()
    telescope_builtin.find_files { find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" } }
end

M.find_files_in_current_dir = function()
    telescope_builtin.find_files({ search_dirs = { vim.fn.expand("%:h") } })
end

M.find_buffers = function()
    telescope_builtin.buffers({
        attach_mappings = function(prompt_bufnr, map)
            map("i", "<c-d>", telescope_actions.delete_buffer)
            map("n", "<c-d>", telescope_actions.delete_buffer)
            map("i", "<c-s>", telescope_actions.select_vertical)
            map("n", "<c-s>", telescope_actions.select_vertical)
            map("i", "<c-i>", telescope_actions.select_horizontal)
            map("n", "<c-i>", telescope_actions.select_horizontal)
            map("i", "<c-t>", telescope_actions.select_tab)
            map("n", "<c-t>", telescope_actions.select_tab)
            return true
        end
    })
end

M.grep_selection = function()
    telescope_builtin.grep_string({ search = _G.utils.get_visual_selection_text()[1] })
end

-- Mappings
wk.register({
    name = "+telescope",
    f = { M.find_files, "Files" },
    b = { M.find_buffers, "Search buffers" },
    c = { d = { M.find_files_in_current_dir, "Search in current directory" } },
    r = { telescope.extensions.live_grep_raw.live_grep_raw, "Fuzzy grep word" },
    w = { telescope_builtin.grep_string, "Grep word under cursor" },
    d = { M.find_dotfiles, "Search dotfiles" },
    s = { n = { M.find_in_std_path, "Find packer packages" } }
}, { prefix = "<leader>f" })

wk.register({ w = { M.grep_selection, "Grep visual selection" } }, { prefix = "<leader>f", mode = "v" })

return M
