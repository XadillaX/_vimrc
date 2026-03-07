return {
  { 'jiangmiao/auto-pairs', event = 'InsertEnter' },
  { 'andymass/vim-matchup', event = 'BufReadPost' },
  { 'Shougo/vimproc.vim', build = 'make', lazy = true },
  { 'mileszs/ack.vim', cmd = 'Ack' },
  { 'editorconfig/editorconfig-vim', event = 'BufReadPost' },
  { 'Yggdroot/LeaderF', build = './install.sh', cmd = { 'Leaderf', 'LeaderfFile', 'LeaderfBuffer', 'LeaderfMru' } },
  { 'f-person/git-blame.nvim', event = 'BufReadPost' },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = false,
    config = function()
      require('nvim-web-devicons').setup()
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    config = function()
      require('plugins.general.nvim-tree')
    end,
  },
  { 'wakatime/vim-wakatime', event = 'VeryLazy' },
}
