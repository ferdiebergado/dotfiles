" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" enable powerline fonts
" let g:airline_powerline_fonts = 1
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''

let g:airline#extensions#tabline#formatter = 'unique_tail'

" Switch to your current theme
"let g:airline_theme = 'kolor'
let g:airline_theme = 'owo'
" let g:airline_theme = 'dromad'

" Always show tabs 
set showtabline=2

" We don't need to see things like -- INSERT -- anymore
set noshowmode

" Set this. Airline will handle the rest.
"let g:airline#extensions#ale#enabled = 1

