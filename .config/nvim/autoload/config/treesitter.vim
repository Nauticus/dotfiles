function! s:InitTreesitter()
lua <<EOF
    require'nvim-treesitter.configs'.setup {
        ensure_installed = { 'typescript', 'tsx' },
        highlight = { enable = true },
        refactor = {
            highlight_definitions = { enable = true },
        },
        incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "gnn",
              node_incremental = "gn[",
              scope_incremental = "gn]",
              node_decremental = "gn)",
            },
        },
        textobjects = {
            select = {
              enable = true,
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@call.inner",

                -- Or you can define your own textobjects like this
                ["iF"] = {
                  python = "(function_definition) @function",
                  cpp = "(function_definition) @function",
                  c = "(function_definition) @function",
                  java = "(method_declaration) @function",
                },
              },
            },
        },
    }
EOF
endfunction

function! config#treesitter#Init()
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
    set foldlevel=100

    call <SID>InitTreesitter()
endfunction
