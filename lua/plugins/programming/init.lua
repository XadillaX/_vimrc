return {
  { 'dense-analysis/ale', event = 'BufReadPost' },
  { 'liuchengxu/vista.vim', cmd = 'Vista', keys = { { '<F8>', ':Vista!!<CR>', desc = 'Toggle Vista' } } },
  { 'neoclide/coc.nvim', branch = 'release', event = 'VeryLazy', build = 'npm install' },
  { 'sheerun/vim-polyglot', event = 'BufReadPost' },
  { 'christoomey/vim-conflicted', cmd = 'Conflicted' },
  { 'vim-scripts/DoxygenToolkit.vim', cmd = 'Dox' },
  { 'akinsho/toggleterm.nvim', version = '*', cmd = 'ToggleTerm' },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', event = { 'BufReadPost', 'BufNewFile' } },
  { 'vim-scripts/supp.vim', ft = 'supp' },
  { 'spacewander/openresty-vim', ft = { 'nginx', 'lua' } },
  { 'github/copilot.vim', event = 'InsertEnter' },
}
