local nvim_lsp = require 'nvim_lsp'
local util = require 'nvim_lsp/util'

local M = {}

local map = function(type, key, value)
    vim.fn.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = true});
end

local on_attach = function(client)
    require'diagnostic'.on_attach(client)
    require'completion'.on_attach(client)

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

local json_schemas = {
    {
        description = 'NPM metadata file',
        fileMatch = {'package.json'},
        url = 'http://json.schemastore.org/package'
    },
    {
        description = 'TypeScript compiler configuration file',
        fileMatch = {'tsconfig.json', 'tsconfig.*.json'},
        url = 'http://json.schemastore.org/tsconfig'
    },
    {
        description = 'Lerna config',
        fileMatch = {'lerna.json'},
        url = 'http://json.schemastore.org/lerna'
    },
    {
        description = 'Babel configuration',
        fileMatch = {'.babelrc.json', '.babelrc', 'babel.config.json'},
        url = 'http://json.schemastore.org/lerna'
    },
    {
        description = 'ESLint config',
        fileMatch = {'.eslintrc.json', '.eslintrc'},
        url = 'http://json.schemastore.org/eslintrc'
    },
    {
        description = 'Prettier config',
        fileMatch = {'.prettierrc', '.prettierrc.json', 'prettier.config.json'},
        url = 'http://json.schemastore.org/prettierrc'
    },
    {
        description = 'Stylelint config',
        fileMatch = {'.stylelintrc', '.stylelintrc.json', 'stylelint.config.json'},
        url = 'http://json.schemastore.org/stylelintrc'
    },
}

-- { {
--     range = {
--       end = {
--         character = 25,
--         line = 69
--       },
--       start = {
--         character = 6,
--         line = 69
--       }
--     },
--     uri = "file:///Users/emanuilganchev/Code/dotfiles/.config/nvim/lua/config/lsp.lua"
--   }, {

-- local sanitize_uri = function(uri)
--     return vim.fn.fnamemodify(vim.uri_to_fname(uri), ':.')
-- end

-- local show_fzf_location = function(source, options)
--     local fzf_run = vim.fn["fzf#run"]
--     local fzf_wrap = vim.fn["fzf#wrap"]

--     local wrapped = fzf_wrap("test", {
--         source = source,
--         options = options,
--         column = 1
--     })
--     wrapped["sink*"] = nil   -- this line is required if you want to use `sink` only
--     wrapped.sink = function(line)
--         print(line)
--     end
--     fzf_run(wrapped)
-- end

-- local location_callback = function(_, method, locations, _)
--     local source = {}

--     for _, location in ipairs(locations) do
--         table.insert(source, string.format('%s:%s:%s', sanitize_uri(location.uri), location.range.start.line, 1))
--     end

--     local options = "--delimiter=: --multi --prompt=\""..method.."> \" --nth 4.."

--     print(vim.inspect(source), options)

--     show_fzf_location(source, options)
-- end

function M.init()
    -- vim.lsp.callbacks['textDocument/references'] = location_callback

    nvim_lsp.tsserver.setup{
        on_attach = on_attach,
    }

    nvim_lsp.jsonls.setup{
        on_attach = on_attach,
        settings = {
            json = {
                schemas = json_schemas
            },
        }
    }

    nvim_lsp.sumneko_lua.setup{
        on_attach = on_attach,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = vim.split(package.path, ';'),
                },
                completion = {
                    keywordSnippet = "Disable",
                },
                diagnostics = {
                    enable = true,
                    globals = { "vim", "describe", "it", "before_each", "after_each" },
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

    nvim_lsp.vimls.setup{
        on_attach = on_attach,
        init_options = {
            runtimepath = vim.api.nvim_get_option('runtimepath'),
        }
    }

    nvim_lsp.intelephense.setup{
        on_attach = on_attach
    }

end

return M
