lua << EOF

require("nvim-tree").setup({
  disable_netrw = true,
  sort_by = "case_sensitive",
  filters = {
    dotfiles = true,
  },
})

EOF

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | Startify | execute 'NvimTreeOpen' | wincmd w | endif
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

" Keymap {
"   Open / close NERDTree {
      nnoremap <leader>fl :NvimTreeToggle<cr>
"   }
" }
