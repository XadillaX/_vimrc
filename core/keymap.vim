" Global leader
let mapleader = '-'

" Open / close quickfix {
  nnoremap <leader>cc :cclose<cr>
  nnoremap <leader>co :copen<cr>
" }

" Select current word {
  map <space> viw
" }

" Open / source vimrc {
  nnoremap <leader>ev :e $MYVIMRC<cr>
  nnoremap <leader>sv :source $MYVIMRC<cr>
" }

" Hexo {
  " TODO: some keymap
" }

" Copy / Paste {
  vnoremap <leader>y "+y
  vnoremap <leader>Y "+Y
  nnoremap <leader>p "+p
  nnoremap <leader>P "+P
" }

" Window {
  nnoremap <silent> <C-j> <C-w>j
  nnoremap <silent> <C-k> <C-w>k
  nnoremap <silent> <C-h> <C-w>h
  nnoremap <silent> <C-l> <C-w>l
" }

" Toggle search highlight {
  nnoremap <leader>/ :set hlsearch! hlsearch?<cr>
" }

if has('nvim')
  nnoremap <silent> <BS> <C-w>h
endif