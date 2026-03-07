require('nvim-tree').setup({
  disable_netrw = true,
  sort_by = 'case_sensitive',
  filters = {
    dotfiles = true,
  },
  git = {
    timeout = 1000,
  },
})

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('NvimTreeAutoOpen', { clear = true })

autocmd('StdinReadPre', {
  group = 'NvimTreeAutoOpen',
  pattern = '*',
  callback = function()
    vim.g.std_in = 1
  end,
})

autocmd('VimEnter', {
  group = 'NvimTreeAutoOpen',
  pattern = '*',
  callback = function()
    if vim.fn.argc() == 0 and vim.g.std_in == nil then
      vim.cmd('Startify')
      vim.cmd('NvimTreeOpen')
      vim.cmd('wincmd w')
    end
  end,
})

autocmd('BufEnter', {
  group = 'NvimTreeAutoOpen',
  pattern = '*',
  nested = true,
  callback = function()
    if vim.fn.winnr('$') == 1 and vim.fn.bufname() == 'NvimTree_' .. vim.fn.tabpagenr() then
      vim.cmd('quit')
    end
  end,
})
