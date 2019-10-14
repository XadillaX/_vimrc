let g:node_include_path = fnamemodify(
            \ fnamemodify($TNVM_PATH != '' ? $TNVM_PATH : $NVM_PATH, ':h'),
            \ ':h')

let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_enable_highlighting = 0

" ESLint / JSHint {
  let g:syntastic_javascript_checkers = [ 'eslint' ]
  let b:syntastic_javascript_checkers =
              \ HasConfig('.eslintrc', expand('%:p:h')) ? ['eslint'] :
              \ HasConfig('.jshintrc', expand('%:p:h')) ? ['jshint'] :
              \ [ 'jshint' ]

  " ESLint Exec
  let g:syntastic_javascript_eslint_exec =
              \ HasConfig('.eslintrc', expand('%:p:h')) ? (expand('%:p:h') . '/node_modules/.bin/eslint') :
              \ g:node_include_path . '/bin/eslint'
  " JSHint Exec
  let g:syntastic_javascript_jshint_exec = g:node_include_path . '/bin/jshint'
" }

" Python {
  let g:syntastic_python_checkers = [ 'pylint' ]
" }
