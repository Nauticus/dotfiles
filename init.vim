" cSpell:disable 

set encoding=utf-8
scriptencoding utf-8

set t_Co=256

set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum

set clipboard=unnamed
set relativenumber
set termguicolors
set cursorline
set hidden
set exrc
set secure
set omnifunc=syntaxcomplete#Complete
set number
set nobackup
set noswapfile
set nowritebackup
set ignorecase
set smartcase
set softtabstop=4
set shiftwidth=4
set expandtab
set updatetime=500
set background=dark
set shell=$SHELL
set signcolumn=yes
set incsearch
set nohlsearch
set list
set listchars=tab:→\ ,trail:⋅,extends:❯,precedes:❮
set lazyredraw

syntax enable

let mapleader = ' '

if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

call plug#begin('~/.vim/plugged')
Plug 'Asheq/close-buffers.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'ekalinin/Dockerfile.vim'
Plug 'aserebryakov/vim-todo-lists'
Plug 'josa42/vim-lightline-coc'
Plug 'tpope/vim-dispatch'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Color Scheme
Plug 'Nauticus/gruvbox'

" Syntax
Plug 'sheerun/vim-polyglot'
call plug#end()

let g:gruvbox_contrast_dark='medium'
let g:gruvbox_invert_selection=0

colo gruvbox

let g:lightline = {
            \ 'colorscheme': 'gruvbox',
            \ 'active': {
            \   'left': [['mode','coc_errors', 'coc_warnings', 'coc_ok'], ['gitbranch','filename','readonly','modified', 'coc-status']]
            \ },
            \ 'component_function': {
            \   'filename': 'LightlineFilename',
            \   'gitbranch': 'FugitiveHead'
            \ }
            \ }

call lightline#coc#register()

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

autocmd CursorHold * silent call CocActionAsync('highlight')

let g:coc_global_extensions = ['coc-json', 'coc-diagnostic', 'coc-git', 'coc-pairs', 'coc-snippets']

" Sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1

let g:dirvish_mode = ':sort ,^.*[\/],'
let g:dirvish_relative_paths = 0

let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0

let g:javascript_plugin_flow = 1
let test#vim#term_position = "belowright"
let g:pumheight = 8
let g:snips_author = "Emanuil Ganchev"

let $FZF_DEFAULT_OPTS = '--layout=reverse'
let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*"'

let g:fzf_preview_window = 'right:45%'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8, 'xoffset': 0.5, 'yoffset': 0.1, 'border': 'rounded' } }

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

nnoremap <SPACE> <Nop>
map <F2> :w<CR>
nmap <leader>; :Files<CR>
nmap <leader>hh :History<CR>
nmap <leader>md <Plug>MarkdownPreviewToggle
nmap <leader>yf :let @* = expand("%")<CR>
nmap <leader>yp :let @* = expand("%") . ':' . line(".") . ' at ' . FugitiveConfigGet('remote.origin.url') . ':' . FugitiveHead()<CR>
nmap <leader>rg :Rg <C-R>*<CR><CR>
nmap <leader>f <Plug>(coc-format)
vmap <leader>s <Plug>(coc-format-selected)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>di :CocList diagnostics<CR>
nmap <leader>a  <Plug>(coc-codeaction)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap § :Buffers<CR>
nnoremap <silent> <leader><leader> :Files <C-R>=expand('%:h')<CR><CR>
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" completion dialog
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

autocmd FileType dirvish vnoremap <leader>ce :Shdo mv {} {}.ts

command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])
