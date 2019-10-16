" Open NERDTree automatically when vim starts up on opening a directory {
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | Startify | NERDTree | wincmd w | endif
" }

" Close Vim if the only window left open is a NERDTree {
  autocmd bufenter * if (winnr("$") == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
  autocmd bufenter * if (winnr("$") == 2 && bufwinnr('__vista__') >= 0 &&
              \ bufwinnr(t:NERDTreeBufName) >= 0) | qa | endif
" }

" Keymap {
"   Open / close NERDTree {
      nnoremap <leader>fl :NERDTreeToggle<cr>
"   }
" }
