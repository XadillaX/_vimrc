local map = vim.keymap.set
local opts = { silent = true }

vim.cmd([[
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]])

map('i', '<Tab>', [[coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()]], { silent = true, expr = true })
map('i', '<S-Tab>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], { silent = true, expr = true })
map('i', '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], { silent = true, expr = true })
map('i', '<C-space>', 'coc#refresh()', { silent = true, expr = true })

map('n', '[g', '<Plug>(coc-diagnostic-prev)', opts)
map('n', ']g', '<Plug>(coc-diagnostic-next)', opts)

map('n', 'gd', '<Plug>(coc-definition)', opts)
map('n', 'gy', '<Plug>(coc-type-definition)', opts)
map('n', 'gi', '<Plug>(coc-implementation)', opts)
map('n', 'gr', '<Plug>(coc-references)', opts)

vim.cmd([[
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
]])

map('n', 'doc', ':call ShowDocumentation()<CR>', { silent = true, desc = 'Show documentation' })

map('n', '<leader>rn', '<Plug>(coc-rename)', opts)

map('x', '<leader>f', '<Plug>(coc-format-selected)', opts)
map('n', '<leader>f', '<Plug>(coc-format-selected)', opts)

map('n', '<space>a', ':<C-u>CocList diagnostics<CR>', { silent = true, nowait = true, desc = 'CocList diagnostics' })
map('n', '<space>e', ':<C-u>CocList extensions<CR>', { silent = true, nowait = true, desc = 'CocList extensions' })
map('n', '<space>c', ':<C-u>CocList commands<CR>', { silent = true, nowait = true, desc = 'CocList commands' })
map('n', '<space>o', ':<C-u>CocList outline<CR>', { silent = true, nowait = true, desc = 'CocList outline' })
map('n', '<space>s', ':<C-u>CocList -I symbols<CR>', { silent = true, nowait = true, desc = 'CocList symbols' })
map('n', '<space>j', ':<C-u>CocNext<CR>', { silent = true, nowait = true, desc = 'CocNext' })
map('n', '<space>k', ':<C-u>CocPrev<CR>', { silent = true, nowait = true, desc = 'CocPrev' })
map('n', '<space>p', ':<C-u>CocListResume<CR>', { silent = true, nowait = true, desc = 'CocListResume' })

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('CocHighlight', { clear = true })
autocmd('CursorHold', {
  group = 'CocHighlight',
  pattern = '*',
  callback = function()
    pcall(vim.fn.CocActionAsync, 'highlight')
  end,
})
