let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_enable_highlighting = 0
let g:syntastic_mode_map = { 'passive_filetypes': [ 'scss', 'slim' ] }

" cpp lint
let g:node_include_path = fnamemodify(
            \ fnamemodify($TNVM_PATH != '' ? $TNVM_PATH : $NVM_PATH, ':h'),
            \ ':h')
let g:syntastic_cpp_include_dirs = [
            \ g:node_include_path . '/include/node',
            \ g:node_include_path . '/lib/node_modules/nan',
            \'/Users/xadillax/Vagrantfile/fuck-ons/node/ons-subscriber/src/third_party/include',
            \'/Users/xadillax/Vagrantfile/fuck-ons/node/ons-subscriber/src/third_party/sole',
            \'/Users/xadillax/Workspace/souche/confbiu/native/deps/HTTP-CLIENT/src',
            \'/usr/local/Cellar/phash/0.9.6_1/include',
            \'/usr/local/include']
let g:syntastic_cpp_compiler_options = '--std=c++11'

" jshintrc
let g:syntastic_javascript_checkers = [ 'jsxhint' ]
autocmd BufNewFile,BufReadPre *.js let b:syntastic_checkers =
            \ HasConfig('.eslintrc', expand('<amatch>:h')) ? ['eslint'] :
            \ HasConfig('.jshintrc', expand('<amatch>:h')) ? ['jsxhint'] :
            \ HasConfig('.jscsrc', expand('<amatch>:h')) ? ['jscs'] :
            \ [ 'jsxhint' ]
autocmd BufNewFile,BufReadPre *.js let g:syntastic_javascript_eslint_exec =
            \ HasConfig('eslint', expand('<amatch>:h')) ? (expand('<amatch>:h') . '/node_modules/.bin/eslint') :
            \ g:node_include_path . '/bin/eslint'
let g:syntastic_javascript_jsxhint_exec = g:node_include_path . '/bin/jsxhint'
let g:syntastic_html_tidy_ignore_errors = [
            \ 'trimming empty <i>',
            \ 'trimming empty <span>',
            \ '<input> proprietary attribute \"autocomplete\"',
            \ 'proprietary attribute \"role\"',
            \ 'proprietary attribute \"hidden\"',
            \ 'proprietary attribute \"ng-',
            \ '<svg> is not recognized!',
            \ '<path> is not recognized!',
            \ 'discarding unexpected <path>',
            \ 'discarding unexpected <svg>',
            \ 'discarding unexpected </svg>',
            \ '<rect> is not recognized!',
            \ 'discarding unexpected <rect>',
            \ '<app> is not recognized!',
            \ 'discarding unexpected <app>',
            \ 'discarding unexpected </app>'
            \ ]

if has("win32")
    let g:syntastic_error_symbol = 'x'
    let g:syntastic_warning_symbol = '!'
endif
