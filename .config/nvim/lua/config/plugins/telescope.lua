local M = {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "kyoh86/telescope-windows.nvim" },
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "benfowler/telescope-luasnip.nvim" },
    },
    keys = {
        {
            "<leader>sf",
            function()
                require("telescope.builtin").find_files()
            end,
            desc = "Find files",
        },
        {
            "<leader>sp",
            function()
                require("telescope.builtin").builtin()
            end,
            desc = "Find Pickers",
        },
        {
            "<leader>sr",
            function()
                require("telescope.builtin").resume()
            end,
            desc = "Resume last picker",
        },
        {
            "<leader>st",
            function()
                require("telescope").extensions.windows.list()
            end,
            desc = "Search windows",
        },
        {
            "<leader>sw",
            function()
                require("telescope.builtin").grep_string()
            end,
            desc = "Grep string",
        },
        {
            "<leader>sg",
            function()
                require("telescope.builtin").grep_string({ search = "" })
            end,
            desc = "Grep interactive",
        },
        {
            "<leader>sw",
            function()
                require("telescope.builtin").grep_string({
                    search = _G.utils.get_visual_selection_text()[1],
                })
            end,
            desc = "Grep visual selection",
        },
    },
}

local send_to_harpoon_action = function(prompt_bufnr)
    local actions_state = require("telescope.actions.state")
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

M.config = function()
    local actions = require("telescope.actions")
    local telescope = require("telescope")

    telescope.setup({
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
            sorting_strategy = "ascending",
            set_env = { ["COLORTERM"] = "truecolor" },
            file_ignore_patterns = { ".git/.*", "node_modules/.*" },
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    width = { padding = 5 },
                    height = { padding = 5 },
                },
            },
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
            lsp_references = {
                theme = "ivy"
            },
            lsp_definitions = {
                theme = "ivy"
            },
            lsp_implementations = {
                theme = "ivy"
            },
            lsp_type_definitions = {
                theme = "ivy"
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
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({}),
            },
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
        },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("windows")
    telescope.load_extension("ui-select")
    telescope.load_extension("luasnip")
end

return M
