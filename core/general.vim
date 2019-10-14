syntax enable
filetype on
filetype plugin on
filetype indent on

set history=400
set autoindent
set cindent
set smartindent

set autoread
set autochdir
set incsearch
set hlsearch
set showmatch
set matchtime=5
set nobackup
set mouse=a
set cursorline

" Tabs {
  set tabstop=4
  set expandtab
  set smarttab
  set shiftwidth=4
  set softtabstop=4
" }

" Ringbell {
  :set noerrorbells
  :set novisualbell

  : set t_vb= " close visual bell
" }

" use <BS> {
  set backspace=indent,eol,start
" }

" Hexo {
  " TODO: some config
" }

" Folding {
  set foldmethod=syntax
  set foldlevelstart=0
" }
