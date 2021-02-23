" Set fzf executable path
set runtimepath+=/usr/bin/fzf
source ~/.config/nvim/plug-config/fzf.vim

" load onedark color theme
"packadd! onedark.vim
"source ~/.config/nvim/themes/onedark.vim

" Airline
packadd! vim-airline
packadd! vim-airline-themes
source ~/.config/nvim/themes/airline.vim

" Git gutter signs
source ~/.config/nvim/plug-config/signify.vim

" Vim-signify's default updatetime 4000ms is not good for async update
"set updatetime=100

" Quick-scope
source ~/.config/nvim/plug-config/quickscope.vim

" coc
source ~/.config/nvim/plug-config/coc2.vim

" Disable the default Ultisnips tab mapping to free up coc.nvim
" let g:UltiSnipsExpandTrigger = "<nop>"

" enable ncm2 for all buffers
" " autocmd BufEnter * call ncm2#enable_for_buffer()
" augroup ncm2
"   au!
"   autocmd BufEnter * call ncm2#enable_for_buffer()
"   au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
"   au User Ncm2PopupClose set completeopt=menuone
" augroup END

" IMPORTANT: :help Ncm2PopupOpen for more information
" set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
" set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
" inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
" inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
" let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
" let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
" let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
" let g:UltiSnipsRemoveSelectModeMappings = 0

" Ale
" let g:ale_linters = {
" \    'sh': ['language_server'],
" \    'lua': ['luacheck'],
" \    'json': ['jq'],
" \    'vim': ['vint'],
" \   'python': ['pyflakes', 'bandit'],
" \   'rust': ['rustc', 'rls']
" \}

" let g:ale_fixers = {
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
" \   'markdown': ['prettier'],
" \   'yaml': ['prettier'],
" \   'json': ['prettier'],
" \   'toml': ['prettier'],
" \   'lua': ['lua.reformat'],
" \   'php': ['phpcbf', 'php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'],
" \   'python': ['black'],
" \   'rust': ['rustfmt']
" \}
" let g:airline#extensions#ale#enabled=0
" let g:ale_completion_enabled=1
"let g:ale_set_loclist = 0
"" let g:ale_set_quickfix = 1
""let g:ale_list_window_size = 5
""let g:ale_fix_on_save=1
"let g:ale_echo_msg_error_str = 'E'
"let g:ale_echo_msg_warning_str = 'W'
"let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:ale_open_list = 1
"let g:ale_keep_list_window_open=0
"let g:ale_set_quickfix=0
"let g:ale_list_window_size = 5
"let g:ale_php_phpcbf_standard='PSR2'
"let g:ale_php_phpcs_standard='phpcs.xml.dist'
"let g:ale_php_phpmd_ruleset='phpmd.xml'
"" Show 5 lines of errors (default: 10)
"let g:ale_list_window_size = 5
" let g:ale_fix_on_save = 1

" Show errors and warnings in the statusline
" function! LinterStatus() abort
"     let l:counts = ale#statusline#Count(bufnr(''))

"     let l:all_errors = l:counts.error + l:counts.style_error
"     let l:all_non_errors = l:counts.total - l:all_errors

"     return l:counts.total == 0 ? 'OK' : printf(
"     \   '%dW %dE',
"     \   all_non_errors,
"     \   all_errors
"     \)
" endfunction
" set statusline=%{LinterStatus()}

" Working with auto-pairs
let g:AutoPairsMapCR=0

" inoremap <silent> <Plug>(MyCR) <CR><C-R>=AutoPairsReturn()<CR>

" " example
" imap <expr> <CR> (pumvisible() ? "\<C-Y>\<Plug>(MyCR)" : "\<Plug>(MyCR)")

" Nvim Colorizer Lua
augroup colorizer
    autocmd!
    autocmd BufEnter * :ColorizerAttachToBuffer
augroup End

" Neoformat
" let g:shfmt_opt="-ci"
" " Autoformat on save
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END

" Vim-rooter
let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh', '.env']
" Auto change directory 
let g:rooter_change_directory_for_non_project_files = 'current'
" let g:rooter_use_lcd = 1
let g:rooter_cd_cmd='lcd'

" coc-vimlsp - document highlight
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]

" vim-polyglot (required)
set nocompatible
"let g:polyglot_disabled = ['graphql.plugin']

" NERDTree
packadd! nerdtree

function! ToggleNerdtree()
  NERDTreeToggle
  silent NERDTreeMirror
endfunction

" NERDTreeToggle
nnoremap <C-n> :call ToggleNerdtree()<CR>

" Open the existing NERDTree on each new tab.
"autocmd BufWinEnter * silent NERDTreeMirror

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" nerdtree-git-plugins should be loaded before vim-devicons
" load NERDTree-git-plugins from opt directory
packadd! nerdtree-git-plugin
" NERDTreeGit - user nerd fonts
"let g:NERDTreeGitStatusUseNerdFonts = 1

" vim-nerdtree-syntax-highlight
packadd! vim-nerdtree-syntax-highlight
" vim-nerdtree-syntax-highlight - Disable uncommon file extensions highlighting
let g:NERDTreeLimitedSyntax = 1
" vim-nerdtree-syntax-highlight - Highlight full name (not only icons)
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" Apprentice colorscheme
packadd! Apprentice
colorscheme apprentice

" packadd! tender.vim
" colorscheme tender

"packadd! Despacio
"let g:despacio_Sunset = 1
"colorscheme despacio

"source ~/.config/nvim/themes/BusyBee.vim
"colorscheme mustang2

" packadd! dromad-vim
" colorscheme dromad

" packadd! onedarkpaco.vim
" colorscheme onedarkpaco

" packadd! ayu-vim
" set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu

" colorscheme slate
