require('nvim-treesitter.configs').setup({
  ensure_installed = { 'c', 'cpp', 'javascript', 'typescript', 'vim' },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  matchup = {
    enable = true,
    disable_virtual_text = true,
    disable = { 'git_rebase', 'gitrebase' },
  },
})
