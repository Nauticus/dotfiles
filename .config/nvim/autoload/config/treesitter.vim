function! s:InitTreesitter()
lua <<EOF
    require'nvim-treesitter.configs'.setup {
        ensure_installed = { 'typescript', 'tsx' },
        highlight = { enable = true },
        refactor = {
            highlight_definitions = { enable = true },
        },
    }
EOF
endfunction

function! config#treesitter#Init()
    call <SID>InitTreesitter()
endfunction
