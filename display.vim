" show line-number
set number
set wrap

" 80 / 120 columns
set cc=80
set cc+=120

" show status line anyway
set ls=2

" show current command
set showcmd

" highlight current line
set cursorline

set t_ut=

" GUI
if has('gui_running')
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R

  if has('mac') || has('gui_macvim')
    set guifont=FantasqueSansMono\ Nerd\ Font:h14
    set guifontwide=FantasqueSansMono\ Nerd\ Font:h14

    " Resolve DevICONs problem
    " https://github.com/ryanoasis/vim-devicons/issues/133#issuecomment-225657905
    set ambiwidth=double

    set transparency=4

    let s:lines=&lines
    let s:columns=&columns
  endif
endif
