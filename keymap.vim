" global leader
let mapleader = '-'

" keymap
"" open / close quickfix
nnoremap <leader>cc :cclose<cr>
nnoremap <leader>co :copen<cr>
"" select current word
map <space> viw
"" open / source vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>:echo webdevicons#hardRefresh()<cr>
"" hexo
nnoremap <leader>hexo :call OpenHexoProjPath()<cr>
vnoremap <leader>y "+y
vnoremap <leader>Y "+Y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <leader>/ :set nohlsearch<cr>
"" Generate CTAGS
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>

if has('nvim')
  nnoremap <silent> <BS> <C-w>h
endif
