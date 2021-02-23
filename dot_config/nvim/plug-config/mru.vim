" set max lenght for the mru file list
let g:mru_file_list_size = 30 " default value
" set path pattens that should be ignored
let g:mru_ignore_patterns = 'fugitive\|\.git/\|\_^/tmp/' " default value

nnoremap <leader>r :Mru<CR>
