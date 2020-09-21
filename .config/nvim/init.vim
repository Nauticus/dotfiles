" cSpell:disable 

let $NVIMRC='~/.config/nvim/init.vim'

scriptencoding utf-8

set encoding=utf-8

if has('termguicolors')
  set termguicolors
endif

set clipboard=unnamed
set completeopt=menuone,noinsert,noselect
set cursorline
set hidden
set exrc
set secure
set relativenumber
set number
set nobackup
set noswapfile
set shortmess+=c
set nowritebackup
set ignorecase
set smartcase
set softtabstop=4
set shiftwidth=4
set expandtab
set updatetime=300
set shell=$SHELL
set signcolumn=yes
set incsearch
set nohlsearch
set list
set listchars=tab:→\ ,trail:⋅,extends:❯,precedes:❮
set lazyredraw
set wrap
set cmdheight=1

syntax on

if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

call plug#begin(stdpath('data') . '/plugged')
Plug 'Asheq/close-buffers.vim'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'junegunn/limelight.vim'
" Plug 'SirVer/ultisnips'
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

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

Plug 'tpope/vim-dispatch'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0

Plug 'rstacruz/vim-closer'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'haorenW1025/diagnostic-nvim'
Plug 'mhartington/formatter.nvim'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/completion-treesitter'

Plug 'norcalli/nvim-colorizer.lua'

Plug 'Nauticus/blue-moon'

" Plug 'sheerun/vim-polyglot'
" let g:polyglot_disabled=['typescript', 'typescriptreact', 'javascript']
call plug#end()

colo blue-moon

let mapleader = ' '

" call config#coc#Init()
call config#fzf#Init()
call config#lightline#Init()
call config#dirvish#Init()
call config#sneak#Init()
lua require'config.lsp'.init()
lua require'config.treesitter'.init()


let g:pumheight = 8
let g:snips_author = "Emanuil Ganchev"

function! s:YankDotInfo()
    return printf('%s:%s at %s:%s', expand('%'), line('.'), FugitiveConfigGet('remote.origin.url'), FugitiveHead())
endfunction

nnoremap <SPACE> <Nop>

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

au TextYankPost * silent! lua vim.highlight.on_yank()
