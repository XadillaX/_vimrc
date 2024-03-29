" JSON {
  au BufNewFile,BufRead *.{jshintrc,eslintrc,changelogrc} set filetype=json
" }

" CocoaPods {
  au BufNewFile,BufRead Podfile,*.podspec set filetype=ruby
" }

" gyp {
  au! BufRead,BufNewFile *.gyp set filetype=python expandtab tabstop=2 shiftwidth=2
  au! BufRead,BufNewFile *.gypi set filetype=python expandtab tabstop=2 shiftwidth=2
  au! BufRead,BufNewFile DEPS set filetype=python expandtab tabstop=2 shiftwidth=2
" }

" supp {
  au BufNewFile,BufRead *.supp set filetype=supp
" }
