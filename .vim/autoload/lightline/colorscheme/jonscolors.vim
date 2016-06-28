" =============================================================================
" Filename: autoload/lightline/colorscheme/jonscolors.vim
" Author: jon
" =============================================================================

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ ['#1a6785', '#52dece', 'bold'], ['white', 'gray4'] ]
let s:p.normal.right = [ ['gray5', 'gray10'], ['gray9', 'gray4'], ['gray8', 'gray2'] ]
let s:p.inactive.right = [ ['gray1', 'gray5'], ['gray4', 'gray1'], ['gray4', 'gray0'] ]
let s:p.inactive.left = s:p.inactive.right[1:]
let s:p.insert.left = [ ['#1bb7f8', 'white', 'bold'], ['white', 'darkblue'] ]
let s:p.insert.right = [ [ '#3ce3dd', '#1fbaf4' ], [ '#1fbaf4', '#335d88' ], [ '#1fbaf4', '#335d88' ] ]
let s:p.replace.left = [ ['white', '#fa6982', 'bold'], ['white', 'gray4'] ]
let s:p.visual.left = [ ['#99517a', '#f49e72', 'bold'], ['white', 'gray4'] ]
let s:p.normal.middle = [ [ 'gray7', 'gray2' ] ]
let s:p.insert.middle = [ [ '#3ce3dd', '#335d88' ] ]
let s:p.replace.middle = s:p.normal.middle
let s:p.replace.right = s:p.normal.right
let s:p.tabline.left = [ [ 'gray9', 'gray4' ] ]
let s:p.tabline.tabsel = [ [ 'gray9', 'gray1' ] ]
let s:p.tabline.middle = [ [ 'gray2', 'gray8' ] ]
let s:p.tabline.right = [ [ 'gray9', 'gray3' ] ]
let s:p.normal.error = [ [ 'gray9', '#fa6982' ] ]
let s:p.normal.warning = [ [ 'gray1', '#ffc750' ] ]

let g:lightline#colorscheme#jonscolors#palette = lightline#colorscheme#fill(s:p)
