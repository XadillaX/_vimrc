" theme information
if has('neovim')
  " for NeoVIM
  
  " for NeoVIM 0.1.3 and 0.1.4
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  " for NeoVIM >= 0.1.5
  if has('termguicolors')
    set termguicolors
  endif
else
  " for VIM

  " for vim 7
  set t_Co=256

  " for vim 8
  if has('termguicolors')
    set termguicolors
  endif
endif

colorscheme OceanicNext

" set theme for airline
let g:airline_theme='oceanicnext'
