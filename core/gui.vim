if has('gui_running') || exists('g:neovim_qt')
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R

  if has('mac') || has('gui_macvim')
    if has('gui_vimr')
      " https://github.com/qvacua/vimr/wiki#commands-from-within-neovim
      " VimRSetFontAndSize "Fantasque Sans Mono Regular Nerd Font Complete Mono", 14
    else
      set guifont=FantasqueSansMono\ Nerd\ Font\ Mono:h13
      set guifontwide=FantasqueSansMono\ Nerd\ Font\ Mono:h13
    endif

    " Resolve DevICONs problem
    " https://github.com/ryanoasis/vim-devicons/issues/133#issuecomment-225657905
    set ambiwidth=double

    " set transparency=4

    let s:lines=&lines
    let s:columns=&columns
  elseif has('unix')
    GuiFont! FantasqueSansMono\ Nerd\ Font\ Mono:h13

    set mouse=a
    GuiTabline 0
  endif
endif
