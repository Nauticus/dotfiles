let $NVIMRC='~/.config/nvim/init.vim'

scriptencoding utf-8

set encoding=utf-8

if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set clipboard=unnamed
set completeopt=menuone,noinsert,noselect
set cursorline
set hidden
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
set redrawtime=1000
set shell=$SHELL
set signcolumn=yes
set incsearch
set nohlsearch
set list
set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»
set lazyredraw
set wrap
set cmdheight=1
set errorformat=%f:%l:%m

syntax on

if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

let g:is_nvim_lsp_enabled = 0

call plug#begin(stdpath('data') . '/plugged')
Plug 'Yggdroot/indentLine'
let g:indentLine_char ='|'

Plug 'ryanoasis/vim-devicons'

Plug 'Asheq/close-buffers.vim'

Plug 'wellle/visual-split.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'editorconfig/editorconfig-vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'junegunn/limelight.vim'

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<Nop>"

Plug 'honza/vim-snippets'

Plug 'tpope/vim-sensible'

Plug 'tpope/vim-abolish'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-fugitive'
" Github
Plug 'tpope/vim-rhubarb'
" Bitbucket
Plug 'tommcdo/vim-fubitive'

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

if g:is_nvim_lsp_enabled
    Plug 'mhinz/vim-signify'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'haorenW1025/diagnostic-nvim'
    Plug 'mhartington/formatter.nvim'
else
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/completion-treesitter'

Plug 'norcalli/nvim-colorizer.lua'

Plug 'Nauticus/gruvbox'
let g:gruvbox_invert_selection=0
let g:gruvbox_improved_strings=0
let g:gruvbox_invert_indent_guides=1
let g:gruvbox_italicize_comments=1
call plug#end()

set background=dark
colo gruvbox

let mapleader = ' '

call config#coc#Init()

call config#fzf#Init()

call config#lightline#Init()

call config#dirvish#Init()

call config#sneak#Init()

if g:is_nvim_lsp_enabled
    lua require'config.lsp'.init()
endif

lua require'config.treesitter'.init()
let g:diagnostic_enable_virtual_text = 0
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_matching_ignore_case = 1

function! s:PrintFileWithColumn()
    let l:file = printf('%s:%s', expand('%:~'), line('.'))
    return printf('%s (%s)', l:file)
endfunction

nnoremap <SPACE> <Nop>

nnoremap <silent> <leader><leader> :Files <C-R>=expand('%:h')<CR><CR>
nmap <leader>; :Files<CR>
nmap <leader>hh :History<CR>
nmap <leader>rg :Rg <C-R>*<CR><CR>
nnoremap § :Buffers<CR>

nmap <leader>wr :vertical resize 127<CR>
nmap <leader>md <Plug>MarkdownPreviewToggle
nmap <leader>yl :let @* = escape(expand("%:t:r"), '/')<CR>
nnoremap <silent> <leader>yf :let @* = expand("%:.")<CR>
nnoremap <silent> <leader>yp :let @* = <SID>PrintFileWithColumn()<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:EchoHighlight()
    let l:hi = synIDattr(synID(line('.'), col('.'), 1), 'name')
    let l:trans = synIDattr(synID(line("."),col("."),0),"name")
    let l:lo = synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")

    echo printf('hi<%s> trans<%s> lo<%s>', l:hi, l:trans, l:lo)
endfunction

nnoremap <silent> <F10> :TSHighlightCapturesUnderCursor<CR>

au TextYankPost * silent! lua vim.highlight.on_yank({ timeout = 500 })
au FileType query setlocal commentstring=;%s
