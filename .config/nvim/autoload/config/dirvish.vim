function! s:Move()
    let l:directory = getline('.')
    let l:input = input('Move to: ', l:directory, "file")
    silent execute printf('!mv "%s" "%s"', l:directory, l:input)
    redraw
endfunction

function! s:Copy()
    let l:item = getline('.')
    let l:input = input('Copy to: ', l:item, 'dir')
    call system(printf('cp -R %s %s', l:item, l:input))
    silent edit
endfunction

function! s:MapToRoot(list)
    return map(a:list, 'expand("%:h") . "/" . v:val')
endfunction

function! s:DirvishTouch(...)
    silent execute printf(':!touch %s', join(<SID>MapToRoot(a:000), ' '))
endfunction

function! s:DirvishMkdir(...)
    let l:options = filter(deepcopy(a:000), 'v:val =~ "-"')
    let l:paths = filter(deepcopy(a:000), 'v:val !~ "-"')
    call system(printf('mkdir %s %s', join(l:options, ' '), join(<SID>MapToRoot(l:paths), ' ')))
    silent edit
endfunction

function! s:DirvishCd(path)
    cd path
    edit path
endfunction

function! config#dirvish#Init()
    let g:dirvish_mode = ':sort ,^.*[\/],'
    let g:dirvish_relative_paths = 0

    command! -nargs=+ DirvishTouch call <SID>DirvishTouch(<f-args>)
    command! -nargs=+ DirvishMkdir call <SID>DirvishMkdir(<f-args>)
    command! -nargs=+ -complete=dir DirvishCd call <SID>DirvishCd(<f-args>)

    augroup dirvish_config
        autocmd!
        autocmd FileType dirvish silent nmap <silent><buffer> <leader>td :!tmux split-window -h -l 80 -c <C-R>=expand('%:p:h')<CR><CR><CR>
        autocmd FileType dirvish nnoremap <silent> <buffer> mv :call <SID>Move()<CR>
        autocmd FileType dirvish nnoremap <silent> <buffer> cp :call <SID>Copy()<CR>
    augroup END
endfunction

