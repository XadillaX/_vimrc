local map = vim.keymap.set

map('n', '<leader>cc', ':cclose<CR>', { desc = 'Close quickfix' })
map('n', '<leader>co', ':copen<CR>', { desc = 'Open quickfix' })

map('n', '<space>', 'viw', { desc = 'Select current word' })

map('n', '<leader>ev', ':e $MYVIMRC<CR>', { desc = 'Edit vimrc' })
map('n', '<leader>sv', ':source $MYVIMRC<CR>', { desc = 'Source vimrc' })

map('v', '<leader>y', '"+y', { desc = 'Copy to clipboard' })
map('v', '<leader>Y', '"+Y', { desc = 'Copy line to clipboard' })
map('n', '<leader>p', '"+p', { desc = 'Paste from clipboard' })
map('n', '<leader>P', '"+P', { desc = 'Paste before from clipboard' })

map('n', '<C-j>', '<C-w>j', { silent = true, desc = 'Window down' })
map('n', '<C-k>', '<C-w>k', { silent = true, desc = 'Window up' })
map('n', '<C-h>', '<C-w>h', { silent = true, desc = 'Window left' })
map('n', '<C-l>', '<C-w>l', { silent = true, desc = 'Window right' })

map('n', '<leader>/', ':set hlsearch! hlsearch?<CR>', { desc = 'Toggle search highlight' })

if vim.fn.has('nvim') == 1 then
  map('n', '<BS>', '<C-w>h', { silent = true, desc = 'Window left (BS)' })
end

map('n', '<leader>fl', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
