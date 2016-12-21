filetype on
filetype plugin on
filetype indent on
syntax on

" custom file type
au BufNewFile,BufRead *.{gyp,tern-project,jshintrc,eslintrc} set filetype=json

" cocoapods
au BufNewFile,BufRead Podfile,*.podspec set filetype=ruby

" nginx
au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf*,/usr/local/nginx/sites-enabled,*nginx*.conf set filetype=nginx
