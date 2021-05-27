local remap = vim.api.nvim_set_keymap
local wk = require("which-key")
local M = {}

remap('n', '<SPACE>', '<Nop>', { noremap = true })

remap('i', '<CR>', 'v:lua.utils.completion_confirm()', { expr = true, noremap = true })

remap("i", "<Tab>",
      table.concat({ "pumvisible() ? \"<C-n>\" : v:lua.utils.check_backspace()", "? \"<Tab>\" : compe#confirm()" }),
      { silent = true, noremap = true, expr = true })

remap("i", "<S-Tab>", "pumvisible() ? \"<C-p>\" : \"<S-Tab>\"", { noremap = true, expr = true })

-- Whichkey mappings

local keymap_leader_p = {
    name = '+telescope',
    h = { '<CMD>Telescope oldfiles<CR>', 'History' },
    b = { '<CMD>Telescope buffers<CR>', 'Buffers' },
    f = { '<CMD>Telescope find_files hidden=true<CR>', 'Files' },
    c = {
        '<CMD>lua require("telescope.builtin").find_files({ search_dirs = {vim.fn.expand("%:h")}})<CR>',
        'Files in current directory'
    },
    r = { '<CMD>lua require("telescope.builtin").live_grep()<CR>', 'Grep word under cursor' },
    d = { '<CMD>lua require("config.plugins.telescope").find_dotfiles()<CR>', 'Search dotfiles' }
}
local keymap_leader_r = {
    name = '+reload',
    l = { '<CMD>luafile %<CR>', 'Reload lua' },
    v = { '<CMD>so %<CR>', 'Reload vim' }
}

local keymap_leader = { r = keymap_leader_r, p = keymap_leader_p }

-- Global mappings

wk.register {
    ["<leader>"] = keymap_leader,
    -- ["-"] = {':e %:h<CR>', 'Parent directory'},
    ["<F10>"] = { ":TSHighlightCapturesUnderCursor<CR>", "(TS) Syntax captures under cursor", silent = true },
    ["<F5>"] = { ":UndotreeToggle<CR>", "Toggle undo tree bar" },
    ["<A-Up>"] = { "<cmd>resize -4<CR>", "Resize -4" },
    ["<A-Down>"] = { "<cmd>resize +4<CR>", "Resize +4" },
    ["<A-Right>"] = { "<cmd>vertical resize +4<CR>", "Vertical Resize +4" },
    ["<A-Left>"] = { "<cmd>vertical resize -4<CR>", "Vertical Resize -4" }
}

-- LSP mappings

M.register_lsp_mappings = function(client, bufnr)
    local keymap_goto = {
        name = '+goto',
        d = { '<Cmd>Telescope lsp_definitions<CR>', 'Go to definition' },
        ['D'] = { '<Cmd>lua vim.lsp.buf.declaration()<CR>', 'Go to declaration' },
        ['i'] = { '<cmd>Telescope lsp_implementations<CR>', 'Go to implementation' },
        ['td'] = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Go to type definition' },
        r = { '<cmd>Telescope lsp_references<CR>', 'Go to references' }
    }

    local keymap_workspaces = {
        name = '+workspaces',
        a = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', 'Add workspace folder' },
        r = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', 'Remove workspace folder' },
        l = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'List workspace folders' }
    }

    local keymap_lsp = {
        name = '+lsp',
        s = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Show signature help' },
        w = keymap_workspaces
    }

    if client.resolved_capabilities.document_formatting then
        keymap_lsp.f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", 'Format' }
    elseif client.resolved_capabilities.document_range_formatting then
        keymap_lsp.f = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format" }
    end

    wk.register({
        ["<leader>l"] = keymap_lsp,
        ["<leader>g"] = keymap_goto,
        ["K"] = { '<cmd>lua vim.lsp.buf.hover()<cr>', 'hover' }
    }, { buffer = bufnr })

end

return M
