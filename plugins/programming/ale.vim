let g:ale_fixers = [ 'prettier', 'eslint' ]
let g:ale_set_quickfix = 1
let g:ale_open_list = 1

let g:ale_linters = {
      \    'typescript': ['tsserver'],
      \    'cpp': ['clangd'],
      \}
let g:ale_cpp_clangd_executable = "/Users/xadillax/.config/coc/extensions/coc-clangd-data/install/10.0.0/clangd_10.0.0/bin/clangd"
