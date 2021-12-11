local wk = require("which-key")
local telescope_builtin = require("telescope.builtin")

local M = {}

M.show_line_diagnostics = function()
    vim.diagnostic.open_float(0, {
        scope = "line",
        source = "always",
        max_width = 120,
        focusable = false,
        border = "single",
        header = "Line Diagnostics:"
    })
end

M.setup = function(client, bufnr)
    local keymap_goto = {
        name = "+goto",
        d = { telescope_builtin.lsp_definitions, "Go to definition" },
        ["D"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
        ["i"] = { telescope_builtin.lsp_implementations, "Go to implementation" },
        ["td"] = { telescope_builtin.lsp_type_definitions, "Go to type definition" },
        r = { telescope_builtin.lsp_references, "Go to references" }
    }

    local keymap_workspaces = {
        name = "+workspaces",
        a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add workspace folder" },
        r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove workspace folder" },
        l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List workspace folders" }
    }

    local keymap_lsp = {
        name = "+lsp",
        s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature help" },
        e = { M.show_line_diagnostics, "Show line diagnostics" },
        r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
        f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },
        a = { telescope_builtin.lsp_code_actions, "Code actions" },
        w = keymap_workspaces
    }

    if client.resolved_capabilities.document_range_formatting then
        wk.register({ ["lf"] = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format selection" } },
            { mode = "v", buffer = bufnr, prefix = "<leader>" })
    end

    wk.register({
        ["<leader>l"] = keymap_lsp,
        ["<leader>g"] = keymap_goto,
        ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "hover" }
    }, { buffer = bufnr })

end

return M
