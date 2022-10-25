if !has('nvim-0.5')
  finish
endif

let g:toggleterm_shade_terminals = 1

lua require'toggleterm'.setup()
