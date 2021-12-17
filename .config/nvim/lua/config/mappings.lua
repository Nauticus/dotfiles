local wk = require "which-key"
local map = vim.api.nvim_set_keymap

local M = {}

-- Global mappings
map("n", "<C-s>", ":update<cr>", { noremap = true })
map("v", "<C-s>", "<esc>:update<cr>", { noremap = true })
map("i", "<C-s>", "<C-o>:update<cr>", { noremap = true })
map("i", "<C-H>", "<BS>", {})

wk.register {
    ["<A-Up>"] = { "<cmd>resize -4<CR>", "Resize -4" },
    ["<A-Down>"] = { "<cmd>resize +4<CR>", "Resize +4" },
    ["<A-Right>"] = { "<cmd>vertical resize +4<CR>", "Vertical Resize +4" },
    ["<A-Left>"] = { "<cmd>vertical resize -4<CR>", "Vertical Resize -4" },
    ["§"] = { "<CMD>NvimTreeToggle<CR>", "Nvim Tree" },
    ["-"] = { "<CMD>NvimTreeFindFile<CR>", "Find file in tree" },
    ["<leader>zm"] = { "<CMD>ZenMode<CR>", "ZenMode" },
}

wk.register({
    name = "+utils",
    r = {
        name = "+source",
        l = { "<CMD>luafile %<CR>", "Source lua file" },
        v = { "<CMD>so %<CR>", "Source vim file" },
    },
    y = { "<CMD>redir @* | file | redir END<CR>", "Paste file info" },
    h = {
        ":TSHighlightCapturesUnderCursor<CR>",
        "(TS) Syntax captures under cursor",
        silent = true,
    },
    u = { ":UndotreeToggle<CR>", "Toggle undo tree bar" },
    s = { ":setlocal spell! spelllang=en_us<CR>", "Toggle spellchecking" },
}, { prefix = "<leader>u" })

M.telescope_mappings = function()
    local prefix = "<leader>f"
    local telescope_builtin = require "telescope.builtin"

    local grep_selection = function()
        telescope_builtin.grep_string { search = _G.utils.get_visual_selection_text()[1] }
    end

    wk.register({
        name = "+telescope",
        f = { telescope_builtin.find_files, "Files" },
        p = { telescope_builtin.builtin, "Pickers" },
        r = { telescope_builtin.resume, "Resume" },
        w = { telescope_builtin.grep_string, "Grep word under cursor" },
    }, { prefix = prefix })

    wk.register(
        { w = { grep_selection, "Grep visual selection" } },
        { prefix = prefix, mode = "v" }
    )
end

M.lsp_mappings = function(client, bufnr)
    local pickers = require "fzf-lua"

    local show_line_diagnostics = function()
        vim.diagnostic.open_float(0, {
            scope = "line",
            source = "always",
            max_width = 120,
            focusable = false,
            border = "single",
            header = "Line Diagnostics:",
        })
    end

    local keymap_goto = {
        name = "+goto",
        d = { pickers.lsp_definitions, "Go to definition" },
        ["D"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
        ["i"] = { pickers.lsp_implementations, "Go to implementation" },
        ["td"] = { pickers.lsp_type_definitions, "Go to type definition" },
        r = { pickers.lsp_references, "Go to references" },
    }

    local keymap_workspaces = {
        name = "+workspaces",
        a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add workspace folder" },
        r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove workspace folder" },
        l = {
            "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
            "List workspace folders",
        },
    }

    local keymap_lsp = {
        name = "+lsp",
        s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature help" },
        e = { show_line_diagnostics, "Show line diagnostics" },
        r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
        f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },
        a = { pickers.lsp_code_actions, "Code actions" },
        w = keymap_workspaces,
    }

    if client.resolved_capabilities.document_range_formatting then
        wk.register(
            { ["lf"] = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format selection" } },
            { mode = "v", buffer = bufnr, prefix = "<leader>" }
        )
    end

    wk.register({
        ["<leader>l"] = keymap_lsp,
        ["<leader>g"] = keymap_goto,
        ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "hover" },
    }, { buffer = bufnr })
end

return M
