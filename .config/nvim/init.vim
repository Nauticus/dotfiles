" cSpell:disable 

scriptencoding utf-8

call options#Init()

call plug#begin(stdpath('data') . '/plugged')
Plug 'Asheq/close-buffers.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call config#coc#Init()

Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call config#fzf#Init()

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
call config#dirvish#Init()

Plug 'justinmk/vim-sneak'
call config#sneak#Init()

Plug 'kristijanhusak/vim-dirvish-git'
Plug 'ekalinin/Dockerfile.vim'
Plug 'aserebryakov/vim-todo-lists'

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
call config#lightline#Init()

Plug 'tpope/vim-dispatch'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0

" Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter'

" Plug 'arcticicestudio/nord-vim'
Plug 'sainnhe/gruvbox-material'
Plug 'Nauticus/gruvbox'
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_invert_selection=0
let g:gruvbox_improved_strings=0
let g:gruvbox_invert_indent_guides=1
let g:gruvbox_italicize_comments=1

Plug 'sheerun/vim-polyglot'
call plug#end()

" call config#lsp#Init()
" call config#treesitter#Init()

let mapleader = ' '

let g:pumheight = 8
let g:snips_author = "Emanuil Ganchev"

function! s:YankDotInfo()
    return printf('%s:%s at %s:%s', expand('%'), line('.'), FugitiveConfigGet('remote.origin.url'), FugitiveHead())
endfunction

nnoremap <SPACE> <Nop>
map <F2> :w<CR>
nnoremap <silent> <leader><leader> :Files <C-R>=expand('%:h:h')<CR><CR>
nmap <leader>; :Files<CR>
nmap <leader>hh :History<CR>
nmap <leader>rg :Rg <C-R>*<CR><CR>
nnoremap § :Buffers<CR>
nmap <leader>wr :vertical resize 127<CR>
nmap <leader>md <Plug>MarkdownPreviewToggle
nmap <leader>yl :let @* = escape(expand("%:t:r"), '/')<CR>
nmap <leader>yf :let @* = expand("%")<CR>
nmap <silent> <leader>yp :let @* = <SID>YankDotInfo()<CR>

function! s:EchoHighlight()
    let l:hi = synIDattr(synID(line('.'), col('.'), 1), 'name')
    let l:trans = synIDattr(synID(line("."),col("."),0),"name")
    let l:lo = synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")

    echo printf('hi<%s> trans<%s> lo<%s>', l:hi, l:trans, l:lo)
endfunction

nnoremap <F10> :call <SID>EchoHighlight()<CR>

colo gruvbox
