local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('FileTypeSettings', { clear = true })

autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'FileTypeSettings',
  pattern = { '*.jshintrc', '*.eslintrc', '*.changelogrc' },
  callback = function()
    vim.bo.filetype = 'json'
  end,
})

autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'FileTypeSettings',
  pattern = { 'Podfile', '*.podspec' },
  callback = function()
    vim.bo.filetype = 'ruby'
  end,
})

autocmd({ 'BufRead', 'BufNewFile' }, {
  group = 'FileTypeSettings',
  pattern = { '*.gyp', '*.gypi', 'DEPS' },
  callback = function()
    vim.bo.filetype = 'python'
    vim.bo.expandtab = true
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
})

autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'FileTypeSettings',
  pattern = '*.supp',
  callback = function()
    vim.bo.filetype = 'supp'
  end,
})

vim.g.indentLine_setConceal = 0

augroup('StartifyNoFold', { clear = true })
autocmd('FileType', {
  group = 'StartifyNoFold',
  pattern = 'startify',
  callback = function()
    vim.wo.foldenable = false
  end,
})
