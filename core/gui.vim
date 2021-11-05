if has('gui_running') || exists('g:neovim_qt')
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R

  if has('mac') || has('gui_macvim')
    set guifont=FantasqueSansMono\ Nerd\ Font\ Mono:h13
    set guifontwide=FantasqueSansMono\ Nerd\ Font\ Mono:h13

    " Resolve DevICONs problem
    " https://github.com/ryanoasis/vim-devicons/issues/133#issuecomment-225657905
    set ambiwidth=double

    set transparency=4

    let s:lines=&lines
    let s:columns=&columns
  elseif has('unix')
    GuiFont! FantasqueSansMono\ Nerd\ Font\ Mono:h13

    set mouse=a
    GuiTabline 0
  endif
endif
