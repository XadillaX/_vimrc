let g:lightline = {
            \   'colorscheme': 'automata',
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
