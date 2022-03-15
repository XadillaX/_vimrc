let g:lightline = {
            \   'colorscheme': 'Mir2',
            \   'active': {
            \     'left': [
            \       [ 'mode', 'paste' ],
            \       [ 'gitbranch', 'readonly', 'filename', 'modified' ]
            \     ]
            \   },
            \   'component_function': {
            \     'gitbranch': 'fugitive#head'
            \   }
            \ }
