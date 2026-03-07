local map = vim.keymap.set

map('n', '<S-k>', ':WintabsPrevious<CR>', { silent = true, desc = 'Previous tab' })
map('n', '<S-j>', ':WintabsNext<CR>', { silent = true, desc = 'Next tab' })
map('n', '<S-w>', ':WintabsClose<CR>', { silent = true, desc = 'Close tab' })

vim.api.nvim_create_user_command('Tabc', 'WintabsCloseVimtab', {})
vim.api.nvim_create_user_command('Tabo', 'WintabsOnlyVimtab', {})

vim.g.wintabs_autoclose_vimtab = 0
