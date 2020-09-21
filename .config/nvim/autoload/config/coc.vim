function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! config#coc#Init()
    let g:coc_global_extensions = ['coc-marketplace', 'coc-diagnostic', 'coc-emmet', 'coc-eslint', 'coc-json', 'coc-git', 'coc-pairs', 'coc-snippets']

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format)
    nmap <leader>f  <Plug>(coc-format)

    " Mappings for CoCList
    " Show all diagnostics.
    nnoremap <silent><nowait> <leader>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent><nowait> <leader>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent><nowait> <leader>p  :<C-u>CocListResume<CR>

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    augroup coc_config
        autocmd!
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup END
endfunction
