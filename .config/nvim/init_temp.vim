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
set noundofile
set shortmess+=c
set nowritebackup
set ignorecase
set smartcase
set softtabstop=4
set shiftwidth=4
set expandtab
set redrawtime=1000
set updatetime=100
set shell=$SHELL
set signcolumn=yes
set incsearch
set nohlsearch
set list
set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»
set lazyredraw
set wrap
set errorformat=%f:%l:%m

syntax on
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

let g:is_nvim_lsp_enabled = 1

call plug#begin(stdpath('data') . '/plugged')
" Plug 'itchyny/lightline.vim'
Plug 'hoob3rt/lualine.nvim'
Plug 'Asheq/close-buffers.vim'
Plug 'wellle/visual-split.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'

" Fugitive
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
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0

Plug 'digitaltoad/vim-pug'

if g:is_nvim_lsp_enabled
    Plug 'mhinz/vim-signify'
    Plug 'neovim/nvim-lspconfig'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'hrsh7th/nvim-compe'
    Plug 'windwp/nvim-autopairs'
else
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/completion-treesitter'
Plug 'norcalli/nvim-colorizer.lua'

Plug 'joshdick/onedark.vim'
let g:onedark_terminal_italics = 1
Plug 'gruvbox-community/gruvbox'
let g:gruvbox_contrast_dark = 'hard'

call plug#end()

set background=dark

colo gruvbox

let mapleader = ' '

call config#fzf#Init()

call config#dirvish#Init()

call config#sneak#Init()

if g:is_nvim_lsp_enabled
    lua require'config.lsp'
    lua require('nvim-autopairs').setup()
    let g:UltiSnipsExpandTrigger = "<nop>"
else
    call config#coc#Init()
endif

lua require'config.lualine'

lua require'config.treesitter'

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

inoremap <silent><expr> <C-y>     compe#confirm('<CR>')
au TextYankPost * silent! lua vim.highlight.on_yank({ timeout = 500 })
au FileType query setlocal commentstring=;%s
