let g:lightline = {
            \   'colorscheme': 'aquarium',
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
