function! s:InitLspConfigs()
lua << EOF
    local nvim_lsp = require('nvim_lsp')

    local on_attach = function(client)
    require'diagnostic'.on_attach(client)
    require'completion'.on_attach(client)
    end

    require'nvim_lsp'.sumneko_lua.setup{
        on_attach = on_attach
    }

    nvim_lsp.tsserver.setup {
        on_attach = on_attach,
    }

    nvim_lsp.jsonls.setup {
        on_attach = on_attach,
    }


    require'nvim_lsp'.vimls.setup{
        on_attach = on_attach
    }

    nvim_lsp.intelephense.setup {
        on_attach = on_attach,
        init_options = {
            licenceKey = "/Users/emanuilganchev/intelephense.txt"
        }
    }
EOF

  function! s:lsp_bindings() abort
    nnoremap <silent> <buffer> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> <buffer> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <buffer> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <buffer> <c-s> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <silent> <buffer> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> <buffer> gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> <buffer> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <silent> <buffer> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
  endfunction

  augroup lsp
    autocmd!
    autocmd FileType go,php,vim,lua,javascript,typescript* call s:lsp_bindings()
    autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()
  augroup END 
endfunction

function! config#lsp#Init()
    call <SID>InitLspConfigs()
    let g:diagnostic_enable_virtual_text = 0
    let g:completion_enable_snippet = 'UltiSnips'
    let g:completion_matching_ignore_case = 1

    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endfunction
