let g:lightline = {
            \   'colorscheme': 'seoul256',
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
