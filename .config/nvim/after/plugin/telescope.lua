local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
    vim.notify("telescope is missing", vim.log.levels.WARN)
    return
end

local actions = require "telescope.actions"
local actions_state = require "telescope.actions.state"
local telescope_builtin = require "telescope.builtin"

local send_to_harpoon_action = function(prompt_bufnr)
    local picker = actions_state.get_current_picker(prompt_bufnr)
    local ok, mark = pcall(require, "harpoon.mark")

    if not ok then
        return
    end

    if #picker:get_multi_selection() < 1 then
        mark.add_file(picker:get_selection()[1])
        return
    end

    for _, entry in ipairs(picker:get_multi_selection()) do
        mark.add_file(entry[1])
    end
end

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
        file_ignore_patterns = { ".git/.*", "node_modules/.*" },
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                width = { padding = 0 },
                height = { padding = 0 },
            },
        },
        prompt_prefix = "",
        border = true,
        mappings = {
            ["i"] = {
                ["<C-?>"] = actions.which_key, -- keys from pressing <C-/>
            },
        },
    },
    pickers = {
        builtin = {
            -- previewer = false,
            include_extensions = true,
        },
        oldfiles = {
            only_cwd = true,
        },
        find_files = {
            find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
            hidden = true,
            mappings = {
                n = {
                    ["<C-h>"] = send_to_harpoon_action,
                },
                i = {
                    ["<C-h>"] = send_to_harpoon_action,
                },
            },
        },
        live_grep = {
            disable_coordinates = true,
        },
    },
    extensions = {
        file_browser = {
            theme = "ivy",
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
        },
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        packer = {
            theme = "ivy",
            layout_config = {
                height = 0.5,
            },
        },
    },
}

telescope.load_extension "fzf"
telescope.load_extension "windows"
telescope.load_extension "ui-select"
telescope.load_extension "packer"
telescope.load_extension "luasnip"

local grep_selection = function()
    telescope_builtin.grep_string { search = _G.utils.get_visual_selection_text()[1] }
end

local function windows()
    telescope.extensions.windows.list()
end

local function grep()
    telescope_builtin.grep_string { search = "" }
end

-- stylua: ignore start
vim.keymap.set("n", "<leader>sf", telescope_builtin.find_files,  { desc = "Find files" })
vim.keymap.set("n", "<leader>sp", telescope_builtin.builtin,     { desc = "Find Pickers" })
vim.keymap.set("n", "<leader>sr", telescope_builtin.resume,      { desc = "Resume last picker" })
vim.keymap.set("n", "<leader>st", windows,                       { desc = "Search windows" })
vim.keymap.set("n", "<leader>sw", telescope_builtin.grep_string, { desc = "Grep string" })
vim.keymap.set("n", "<leader>sg", grep,                          { desc = "Grep interactive" })
vim.keymap.set("v", "<leader>sw", grep_selection,                { desc = "Grep visual selection" })
-- stylua: ignore end
