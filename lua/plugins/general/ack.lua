vim.cmd('cnoreabbrev Ack Ack!')
vim.keymap.set('n', '<Leader>a', ':Ack!<Space>', { desc = 'Ack search' })
