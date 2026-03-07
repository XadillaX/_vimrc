vim.g.ale_fixers = { 'prettier', 'eslint' }
vim.g.ale_set_quickfix = 1
vim.g.ale_open_list = 1

vim.g.ale_linters = {
  typescript = { 'eslint' },
  cpp = { 'cpplint' },
  c = { 'cpplint' },
  json = {},
  python = {},
}

vim.g.ale_cpp_cpplint_executable = 'cpplint'
vim.g.ale_c_clangd_executable = 'clangd'
vim.g.ale_c_cpp_clangd_executable = 'clangd'
vim.g.ale_cpp_clangd_executable = 'clangd'
