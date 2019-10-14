" JSON {
  au BufNewFile,BufRead *.{gyp,tern-project,jshintrc,eslintrc,changelogrc} set filetype=json
" }

" CocoaPods {
  au BufNewFile,BufRead Podfile,*.podspec set filetype=ruby
" }
