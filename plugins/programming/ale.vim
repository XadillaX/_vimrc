let g:ale_fixers = [ 'prettier', 'eslint' ]
let g:ale_set_quickfix = 1
let g:ale_open_list = 1

let g:ale_linters = {
      \    'typescript': ['eslint'],
      \    'cpp': ['cpplint'],
      \    'c': ['cpplint'],
      \    'json': [],
      \}

let g:ale_cpp_cpplint_executable = "/home/xadillax/Workspace/taobao/strontium/vendor/cpplint/cpplint.py"
let g:ale_c_clangd_executable = "/usr/bin/clangd-9"
let g:ale_c_cpp_clangd_executable = "/usr/bin/clangd-9"
let g:ale_cpp_clangd_executable = "/usr/bin/clangd-9"
