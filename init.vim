set encoding=utf8
scriptencoding utf-8

set t_Co=256

set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum

set clipboard=unnamed
set termguicolors
set cursorline
set hidden
set exrc
set secure
set omnifunc=syntaxcomplete#Complete
set number
set nobackup
set ignorecase
set smartcase
set softtabstop=4
set shiftwidth=4
set expandtab
set updatetime=400
set background=dark
set shell=$SHELL
set signcolumn=yes
set incsearch
set nohlsearch
set list
set listchars=tab:→\ ,trail:⋅,extends:❯,precedes:❮

syntax enable
syntax sync minlines=200

let mapleader = ' '

if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

call plug#begin('~/.vim/plugged')
Plug 'Asheq/close-buffers.vim'
Plug 'tpope/vim-sensible'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'justinmk/vim-sneak'
Plug 'christoomey/vim-tmux-navigator'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'rakr/vim-one'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-projectionist'
Plug 'pangloss/vim-javascript'
call plug#end()

let g:one_allow_italics = 1

colo one

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction


" When switching buffers, preserve window view.
autocmd BufLeave * call AutoSaveWinView()
autocmd BufEnter * call AutoRestoreWinView()
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
let g:sneak#target_labels = ";sfghltunrqz/0"

let g:dirvish_mode = ':sort ,^.*[\/],'
let g:dirvish_relative_paths = 0

let g:netrw_localmovecmd = 'mv'
let g:netrw_fastbrowse = 0
let g:javascript_plugin_flow = 1
let test#vim#term_position = "belowright"
let g:pumheight = 8
let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*"'
let g:snips_author = "Emanuil Ganchev"
let g:netrw_localrmdir='rm -r'
let g:loaded_matchparen = 1

nnoremap <SPACE> <Nop>
map <F2> :w<CR>
nmap <leader>; :Files<CR>
nmap <leader>hh :History<CR>
nmap <leader>yf :let @* = expand("%")<CR>
nmap <leader>rg :Rg <C-R>=expand("<cword>")<CR><CR>
nmap <leader>f <Plug>(coc-format)
vmap <leader>s <Plug>(coc-format-selected)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>di :CocList diagnostics<CR>
nmap <leader>a  <Plug>(coc-codeaction)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent>  :call fzf#run(fzf#wrap({'source': 'find . -type d \( -path ./node_modules -o -path ./.git \) -prune -o -print'}))<CR>
nnoremap § :Buffers<CR>
nnoremap <silent> <leader><leader> :Files <C-R>=expand('%:h')<CR><CR>

"replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
"replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

" completion dialog
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

hi Sneak gui=bold guifg=#353a44 guibg=#72bef2
hi SneakScope  guifg=#282C34 guibg=#E5C07B
hi SneakLabelMask guifg=#72bef2 guibg=#72bef2
