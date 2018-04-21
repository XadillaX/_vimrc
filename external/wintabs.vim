nnoremap <S-k> :WintabsPrevious<cr>
nnoremap <S-j> :WintabsNext<cr>
nnoremap <S-w> :WintabsClose<cr>
command! Tabc WintabsCloseVimtab
command! Tabo WintabsOnlyVimtab

let g:wintabs_autoclose_vimtab = 0
