local api = vim.api
local nvim_lsp = require('nvim_lsp')

local M = {}

local map = function(type, key, value)
    vim.fn.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
end

local on_attach = function(client)
    require'diagnostic'.on_attach(client)
    require'completion'.on_attach(client)

    api.nvim_exec([[
      augroup lsp
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()
      augroup END
    ]], '')

    map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
    map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
    map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
    map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
    map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
    map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
    map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
    map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
    map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
    map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
    map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
    map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
    map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
end

function M.init()
    nvim_lsp.sumneko_lua.setup{
        on_attach = on_attach,
        settings = {
            Lua = {
                runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
                completion = { keywordSnippet = "Disable", },
                diagnostics = { enable = true, globals = {
                    "vim", "describe", "it", "before_each", "after_each" },
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    }
                }
            }
        }
    }

    nvim_lsp.tsserver.setup {
        on_attach = on_attach,
    }

    nvim_lsp.jsonls.setup {
        on_attach = on_attach,
    }


    nvim_lsp.vimls.setup{
        on_attach = on_attach
    }

    nvim_lsp.intelephense.setup {
        on_attach = on_attach,
        init_options = {
            licenceKey = "/Users/emanuilganchev/intelephense.txt"
        }
    }
end

return M
