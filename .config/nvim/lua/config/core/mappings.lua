local wk = require "which-key"
local keymap = vim.keymap

wk.register {
    ["<localleader>u"] = {
        name = "+utils",
    },
}

-- GLOBAL MAPPINGS
-- stylua: ignore start
keymap.set("n", "<C-s>",           "<CMD>update<CR>",                      { desc = "Update buffer" })
keymap.set("v", "<C-s>",           "<CMD>:update<CR>gv",                   { desc = "Update buffer" })
keymap.set("i", "<C-s>",           "<C-O>:update<CR>",                     { desc = "Update buffer" })

keymap.set("i", "<C-h>",           "<BS>",                                 { desc = "Backspace" })

keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Down half page" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Up half page" })

keymap.set("n", "<A-Up>",          "<CMD>resize -4<CR>",                   { desc = "- resize" })
keymap.set("n", "<A-Down>",        "<CMD>resize +4<CR>",                   { desc = "+ resize" })
keymap.set("n", "<A-Right>",       "<CMD>vertical resize +4<CR>",          { desc = "+ vertical resize" })
keymap.set("n", "<A-Left>",        "<CMD>vertical resize -4<CR>",          { desc = "- vertical resize" })

-- UTILS (u)
keymap.set("n", "<localleader>ur", "<CMD>so %<CR>",                        { desc = "Source file" })
keymap.set("n", "<localleader>uy", "<CMD>redir @* | file | redir END<CR>", { desc = "Paste file info" })
keymap.set("n", "<localleader>uh", ":TSHighlightCapturesUnderCursor<CR>",  { desc = "(TS) Syntax captures under cursor", silent = true })
keymap.set("n", "<localleader>us", ":setlocal spell! spelllang=en_us<CR>", { desc = "Toggle spellchecking" })
keymap.set("n", "<localleader>uu", ":UndotreeToggle<CR>",                  { desc = "Toggle UndoTreee" })
-- stylua: ignore end

local M = {}

M.lir = function()
    -- stylua: ignore start
    keymap.set("n", "§", "<CMD>e .<CR>",     { desc = "Open current working directory" })
    keymap.set("n", "-", "<CMD>e %:p:h<CR>", { desc = "Open parent directory" })
    -- stylua: ignore end
end

M.harpoon = function()
    local harpoon_ui = require "harpoon.ui"

    wk.register({ name = "+harpoon" }, { prefix = "<leader>h" })

    -- stylua: ignore start
    keymap.set("n", "[h",         harpoon_ui.nav_prev,              { desc = "Previous mark (Harpoon)" })
    keymap.set("n", "]h",         harpoon_ui.nav_next,              { desc = "Next mark (Harpoon)" })

    keymap.set("n", "<leader>hh", harpoon_ui.toggle_quick_menu,     { desc = "Toggle Harpoon UI" })
    keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "Mark file (Harpoon)" })
    -- stylua: ignore end
end

M.telescope = function()
    local prefix = "<leader>s"
    local telescope_builtin = require "telescope.builtin"

    wk.register({ name = "+telescope" }, { prefix = prefix, mode = "v" })
    wk.register({ name = "+telescope" }, { prefix = prefix, mode = "n" })

    local grep_selection = function()
        telescope_builtin.grep_string { search = _G.utils.get_visual_selection_text()[1] }
    end

    local function windows()
        require("telescope").extensions.windows.list()
    end

    local function grep()
        telescope_builtin.grep_string { search = "" }
    end

    -- stylua: ignore start
    keymap.set("n", "<leader>sf", telescope_builtin.find_files,  { desc = "Find files" })
    keymap.set("n", "<leader>sp", telescope_builtin.builtin,     { desc = "Find Pickers" })
    keymap.set("n", "<leader>sr", telescope_builtin.resume,      { desc = "Resume last picker" })
    keymap.set("n", "<leader>st", windows,                       { desc = "Search windows" })
    keymap.set("n", "<leader>sw", telescope_builtin.grep_string, { desc = "Grep string" })
    keymap.set("n", "<leader>sg", grep,                          { desc = "Grep interactive" })
    keymap.set("v", "<leader>sw", grep_selection,                { desc = "Grep visual selection" })
    -- stylua: ignore end
end

M.lsp = function(client, bufnr)
    local pickers = require "telescope.builtin"
    local capabilities = client.server_capabilities

    wk.register({ name = "+goto" }, { prefix = "<localleader>g" })
    wk.register({ name = "+lsp" }, { prefix = "<localleader>l" })

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

    local lsp_formatting = function()
        vim.lsp.buf.format {
            filter = function(c)
                return c.name ~= "sumneko_lua"
            end,
            bufnr = bufnr,
        }
    end

    local list_workspaces = function()
        vim.pretty_print(vim.lsp.buf.list_workspace_folter())
    end

    -- Go to
    -- stylua: ignore start
    if capabilities.definitionProvider then
        keymap.set("n", "<localleader>gd", pickers.lsp_definitions,      { desc = "Go to definition",           buffer = bufnr })
    end
    if capabilities.declarationProvider then
        keymap.set("n", "<localleader>gD", vim.lsp.buf.declaration,      { desc = "Go to declaration",          buffer = bufnr })
    end
    if capabilities.implementationProvider then
        keymap.set("n", "<localleader>gi", pickers.lsp_implementations,  { desc = "Go to implementation",       buffer = bufnr })
    end
    if capabilities.typeDefinitionProvider then
        keymap.set("n", "<localleader>gt", pickers.lsp_type_definitions, { desc = "Go to type definition",      buffer = bufnr })
    end
    if capabilities.referencesProvider then
        keymap.set("n", "<localleader>gr", pickers.lsp_references,       { desc = "Go to reference",            buffer = bufnr })
    end

    -- Lsp specific
    if capabilities.signatureHelpProvider then
        keymap.set("n", "<localleader>ls", vim.lsp.buf.signature_help,   { desc = "Show signature help",        buffer = bufnr })
    end
    if capabilities.renameProvider then
        keymap.set("n", "<localleader>lr", vim.lsp.buf.rename,           { desc = "Rename symbol under cursor", buffer = bufnr })
    end
    if capabilities.documentFormattingProvider then
        keymap.set("n", "<localleader>lf", lsp_formatting,               { desc = "Format",                     buffer = bufnr })
    end
    -- if capabilities.documentRangeFormattingProvider then
    --     keymap.set("v", "<localleader>lf", vim.lsp.buf.range_formatting, { desc = "Range format" })
    -- end
    if capabilities.codeActionProvider then
        keymap.set("n", "<localleader>la", vim.lsp.buf.code_action,      { desc = "Code actions",               buffer = bufnr })
    end

    if capabilities.hoverProvider then
        keymap.set("n", "K",               vim.lsp.buf.hover,            { desc = "Hover",                      buffer = bufnr })
    end

    keymap.set("n", "<localleader>le",  show_line_diagnostics,               { desc = "Show line diagnostics", buffer = bufnr })

    -- Workspaces
    keymap.set("n", "<localleader>lwa", vim.lsp.buf.add_workspace_folder,    { desc = "Add workspace folder" })
    keymap.set("n", "<localleader>lwr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
    keymap.set("n", "<localleader>lwl", list_workspaces,                     { desc = "List workspace folders" })
    -- stylua: ignore end
end

return M
