local g = vim.g
local tree_cb = require"nvim-tree.config".nvim_tree_callback

g.nvim_tree_indent_markers = 1
g.nvim_tree_group_empty = 1
g["nvim_tree_show_icons"] = { ["git"] = 1, ["folder"] = 1, ["files"] = 0, ["folder_arrows"] = 0 }

g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        deleted = "",
        ignored = "◌",
        renamed = "➜",
        staged = "✓",
        unmerged = "",
        unstaged = "✗",
        untracked = "★"
    },
    folder = {
        arrow_open = "",
        arrow_closed = "",
        default = "",
        empty = "",
        empty_open = "",
        open = "",
        symlink = "",
        symlink_open = ""
    }
}

require("nvim-tree").setup({
    hijack_cursor = true,
    open_on_start = true,
    ignore_ft_on_setup = { "packer", "qf", "Trouble", "fugitiveblame", "help" },
    open_on_directory = true,
    open_on_tab = false,
    update_focused_file = { enable = true, update_cwd = false },
    view = {
        width = 40,
        auto_resize = true,
        mappings = {
            custom_only = true,
            list = {
                { key = { "<CR>", "<2-LeftMouse>" }, cb = tree_cb("edit") },
                { key = { "<2-RightMouse>", "<C-]>" }, cb = tree_cb("cd") },
                { key = "<C-v>", cb = tree_cb("vsplit") },
                { key = "<C-x>", cb = tree_cb("split") },
                { key = "<C-t>", cb = tree_cb("tabnew") },
                { key = "<", cb = tree_cb("prev_sibling") },
                { key = ">", cb = tree_cb("next_sibling") },
                { key = "P", cb = tree_cb("parent_node") },
                { key = "<BS>", cb = tree_cb("close_node") },
                { key = "<S-CR>", cb = tree_cb("close_node") },
                { key = "<Tab>", cb = tree_cb("preview") },
                { key = "K", cb = tree_cb("first_sibling") },
                { key = "J", cb = tree_cb("last_sibling") },
                { key = "I", cb = tree_cb("toggle_ignored") },
                { key = "H", cb = tree_cb("toggle_dotfiles") },
                { key = "R", cb = tree_cb("refresh") },
                { key = "a", cb = tree_cb("create") },
                { key = "d", cb = tree_cb("remove") },
                { key = "r", cb = tree_cb("rename") },
                { key = "<C-r>", cb = tree_cb("full_rename") },
                { key = "x", cb = tree_cb("cut") },
                { key = "c", cb = tree_cb("copy") },
                { key = "p", cb = tree_cb("paste") },
                { key = "y", cb = tree_cb("copy_name") },
                { key = "Y", cb = tree_cb("copy_path") },
                { key = "gy", cb = tree_cb("copy_absolute_path") },
                { key = "[c", cb = tree_cb("prev_git_item") },
                { key = "]c", cb = tree_cb("next_git_item") },
                { key = "-", cb = tree_cb("dir_up") },
                { key = "o", cb = tree_cb("system_open") },
                { key = "q", cb = tree_cb("close") },
                { key = "g?", cb = tree_cb("toggle_help") }
            }
        }
    },
    filter = { custom = { ".git" } },
    diagnostics = { enable = true },
    git = { enable = true }
})