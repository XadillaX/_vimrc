" Set for lightline {
  function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
  endfunction
  
  set statusline+=%{NearestMethodOrFunction()}
  autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
  
  call insert(g:lightline['active']['left'][1], 'method', 3)
  let g:lightline['component_function']['method'] = 'NearestMethodOrFunction'
" }

let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 1
let g:vista_icon_indent = [ '▸ ', '' ]
