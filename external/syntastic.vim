let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_enable_highlighting = 0
let g:syntastic_mode_map = { 'passive_filetypes': [ 'scss', 'slim' ] }

" cpp
let g:node_include_path = fnamemodify(
            \ fnamemodify($TNVM_PATH != '' ? $TNVM_PATH : $NVM_PATH, ':h'),
            \ ':h')
let g:syntastic_cpp_include_dirs = [
            \ g:node_include_path . '/include/node',
            \ g:node_include_path . '/lib/node_modules/nan',
            \'/Users/xadillax/Workspace/souche/confbiu/native/deps/HTTP-CLIENT/src',
            \'/usr/local/include',
            \'/Users/xadillax/Workspace/c/',
            \'/Users/xadillax/.nvm/versions/node/v8.11.1/lib/node_modules/nan',
            \'/Users/xadillax/.nvm/versions/node/v8.11.1/include/node']
let g:syntastic_cpp_compiler_options = '--std=c++11'

" c
let g:syntastic_c_include_dirs = [
            \'/usr/local/include',
            \'/usr/local/src/openssl-1.0.2k/include',
            \'/usr/local/src/openresty-1.11.2.2/build/ngx_lua-0.10.7/src/api',
            \'/usr/local/src/openresty-1.11.2.2/build/nginx-1.11.2/src/core',
            \'/usr/local/src/openresty-1.11.2.2/build/nginx-1.11.2/src/dtrace',
            \'/usr/local/src/openresty-1.11.2.2/build/nginx-1.11.2/src/event',
            \'/usr/local/src/openresty-1.11.2.2/build/nginx-1.11.2/src/http',
            \'/usr/local/src/openresty-1.11.2.2/build/nginx-1.11.2/src/http/modules',
            \'/usr/local/src/openresty-1.11.2.2/build/nginx-1.11.2/src/mail',
            \'/usr/local/src/openresty-1.11.2.2/build/nginx-1.11.2/src/misc',
            \'/usr/local/src/openresty-1.11.2.2/build/nginx-1.11.2/src/os',
            \'/usr/local/src/openresty-1.11.2.2/build/nginx-1.11.2/src/os/unix',
            \'/usr/local/src/openresty-1.11.2.2/build/nginx-1.11.2/src/stream',
            \'/usr/local/src/openresty-1.11.2.2/build/nginx-1.11.2/objs']

" jshint
let g:syntastic_javascript_checkers = ['eslint']
let b:syntastic_checkers =
            \ HasConfig('.eslintrc', expand('%:p:h')) ? ['eslint'] :
            \ HasConfig('.jshintrc', expand('%:p:h')) ? ['jshint'] :
            \ ['jshint']
let g:syntastic_javascript_eslint_exec =
            \ HasConfig('.eslintrc', expand('%:p:h')) ? (expand('%:p:h') . '/node_modules/.bin/eslint') :
            \ g:node_include_path . '/bin/eslint'
let g:syntastic_javascript_jshint_exec = g:node_include_path . '/bin/jshint'
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

let g:syntastic_debug = 0

" Windows
if has("win32")
    let g:syntastic_error_symbol = 'x'
    let g:syntastic_warning_symbol = '!'
endif
