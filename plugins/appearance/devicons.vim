" https://github.com/ryanoasis/vim-devicons/wiki/Extra-Configuration

" specify OS to decide an icon for unix fileformat (not defined by default) {
  let g:WebDevIconsOS = 'Darwin'
" }

" https://github.com/ryanoasis/vim-devicons/wiki/FAQ-&-Troubleshooting#how-do-i-solve-issues-after-re-sourcing-my-vimrc
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif
