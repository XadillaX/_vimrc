if has('termguicolors')
  " for neovim >= 0.1.5 and vim >= 8
  let &t_8f = '\<Esc>[38;2;%lu;%lu;%lum'
  let &t_8b = '\<Esc>[48;2;%lu;%lu;%lum'
  set termguicolors
elseif has('neovim')
  " for neovim 0.1.3 and 0.1.4
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
else
  " for vim 7
  set t_Co=256
endif

set background=light
colorscheme automata

" Show line-number {
  set number
  set wrap
" }

" 80 / 120 columns {
  set cc=80
  set cc+=120
" }

" Show status line anyway {
  set ls=2
" }

" Show current command {
  set showcmd
" }

" Highlight current line {
  set cursorline
" }

set t_ut=
