let mapleader = '-'
let maplocalleader = '-'

set langmenu=zh_cn
set encoding=utf-8

set number
set wrap
set cursorline
set signcolumn=yes
set colorcolumn=80,120
set laststatus=2
set showcmd
set background=dark

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set autoindent
set smartindent
set cindent

set incsearch
set hlsearch
set showmatch
set matchtime=5

set autoread
set autochdir
set mouse=a
set backspace=indent,eol,start
set history=400

set nobackup
set nowritebackup

set noeb
set novb
set t_vb=

if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set t_ut=

nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>co :copen<CR>
nnoremap <space> viw
vnoremap <leader>y "+y
vnoremap <leader>Y "+Y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <leader>/ :set hlsearch! hlsearch?<CR>

try
  colorscheme sonokai
catch
  try
    colorscheme gruvbox
  catch
    colorscheme desert
  endtry
endtry
