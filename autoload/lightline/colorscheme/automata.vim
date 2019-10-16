if &background == 'light'
  
let s:shade0 = "#dad4bb"
let s:shade1 = "#cac4ad"
let s:shade2 = "#b9b49f"
let s:shade3 = "#a9a491"
let s:shade4 = "#999482"
let s:shade5 = "#898474"
let s:shade6 = "#787466"
let s:shade7 = "#686458"
let s:accent0 = "#cd664d"
let s:accent1 = "#b4af9a"
let s:accent2 = "#3ba99f"
let s:accent3 = "#727b59"
let s:accent4 = "#4e4c43"
let s:accent5 = "#5e6666"
let s:accent6 = "#b26f5f"
let s:accent7 = "#50403c"

endif


let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:shade1, s:accent5 ], [ s:shade7, s:shade2 ] ]
let s:p.normal.right = [ [ s:shade1, s:shade4 ], [ s:shade5, s:shade2 ] ]
let s:p.inactive.right = [ [ s:shade1, s:shade3 ], [ s:shade3, s:shade1 ] ]
let s:p.inactive.left =  [ [ s:shade4, s:shade1 ], [ s:shade3, s:shade0 ] ]
let s:p.insert.left = [ [ s:shade1, s:accent3 ], [ s:shade7, s:shade2 ] ]
let s:p.replace.left = [ [ s:shade1, s:accent1 ], [ s:shade7, s:shade2 ] ]
let s:p.visual.left = [ [ s:shade1, s:accent6 ], [ s:shade7, s:shade2 ] ]
let s:p.normal.middle = [ [ s:shade5, s:shade1 ] ]
let s:p.inactive.middle = [ [ s:shade4, s:shade1 ] ]
let s:p.tabline.left = [ [ s:shade6, s:shade2 ] ]
let s:p.tabline.tabsel = [ [ s:shade6, s:shade0 ] ]
let s:p.tabline.middle = [ [ s:shade2, s:shade4 ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:accent0, s:shade0 ] ]
let s:p.normal.warning = [ [ s:accent2, s:shade1 ] ]

let g:lightline#colorscheme#automata#palette = lightline#colorscheme#fill(s:p)
