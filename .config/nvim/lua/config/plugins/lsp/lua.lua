local lsp_config = require('lspconfig')
local on_attach = require('config.plugins.lsp.attach')

local sumenko_cmd = vim.fn.stdpath('data') .. '/lspinstall/lua/sumneko-lua-language-server'

lsp_config.sumneko_lua.setup {
    cmd = {sumenko_cmd},
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
            }
        }
    }
}
