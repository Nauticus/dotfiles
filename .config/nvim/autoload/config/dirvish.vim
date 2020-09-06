function! s:CreateDirectory() abort
    let dirname = input('Directory name: ')
    if trim(dirname) == ''
	return
    endif
    let dirpath = expand("%") . dirname
    if isdirectory(dirpath)
	redraw
	echomsg printf('"%s" already exists.', dirpath)
	return
    endif
    let output = system("mkdir -p " . dirpath)
    if v:shell_error
	call s:logError(output)
    endif
    normal R
endfunction

function! s:RenameItemUnderCursor()
    let target = getline('.')
    let filename = fnamemodify(target, ':t')
    let path = fnamemodify(target, ':p:h')
    let newname = input('Rename into: ', filename)
    let newpath = path . '/' . newname
    silent execute(printf(':!mv "%s" "%s"',target,newpath))
    normal R
endfunction

function! s:ResolveToRoot(list)
    return map(copy(a:list), 'expand("%:h") . "/" . v:val')
endfunction

function! s:DirvishTouch(...)
    silent execute printf(':!touch %s', join(<SID>ResolveToRoot(a:000), ' '))
endfunction

function! s:DirvishMkdir(...)
    let s:options = filter(copy(a:000), 'v:val =~ "-"')
    let s:paths = filter(copy(a:000), 'v:val !~ "-"')
    silent execute printf(':!mkdir %s %s', join(s:options, ' '), join(<SID>ResolveToRoot(s:paths), ' '))
endfunction


function! config#dirvish#Init()
    let g:dirvish_mode = ':sort ,^.*[\/],'
    let g:dirvish_relative_paths = 0

    command! -nargs=+ DirvishTouch call <SID>DirvishTouch(<f-args>)
    command! -nargs=+ DirvishMkdir call <SID>DirvishMkdir(<f-args>)

    augroup dirvish_config
	autocmd!
	autocmd FileType dirvish silent nmap <silent><buffer> <leader>td :!tmux split-window -h -l 80 -c <C-R>=expand('%:p:h')<CR><CR><CR>
	autocmd FileType dirvish nnoremap <silent> <buffer> <leader>rn :call <SID>RenameItemUnderCursor()<CR>
	autocmd FileType dirvish nnoremap <silent> <buffer> <leader>cd :call <SID>CreateDirectory()<CR>
    augroup END
endfunction

