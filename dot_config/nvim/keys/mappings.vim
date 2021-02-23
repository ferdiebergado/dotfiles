
" Better indenting
vnoremap < <gv
vnoremap > >gv

if exists('g:vscode')

" Simulate same TAB behavior in VSCode
nmap <Tab> :Tabnext<CR>
nmap <S-Tab> :Tabprev<CR>

else
  " Better nav for omnicomplete
  inoremap <expr> <c-j> ("\<C-n>")
  inoremap <expr> <c-k> ("\<C-p>")

  " I hate escape more than anything else
  inoremap jk <Esc>
  inoremap kj <Esc>

  " Easy CAPS
  " inoremap <c-u> <ESC>viwUi
  " nnoremap <c-u> viwU<Esc>

  " TAB in general mode will move to text buffer
  nnoremap <TAB> :bnext<CR>
  " SHIFT-TAB will go back
  nnoremap <S-TAB> :bprevious<CR>

  " Alternate way to save
  nnoremap <C-s> :w<CR>
  " Alternate way to quit
  nnoremap <C-Q> :wq!<CR>
  " Use control-c instead of escape
  nnoremap <C-c> <Esc>
  " <TAB>: completion.
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"


  " Better window navigation
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l

  " Use alt + hjkl to resize windows
  nnoremap <M-j>    :resize -2<CR>
  nnoremap <M-k>    :resize +2<CR>
  nnoremap <M-h>    :vertical resize -2<CR>
  nnoremap <M-l>    :vertical resize +2<CR>

  " Move lines up or down
  nnoremap mj :m .+1<CR>==
  nnoremap mk :m .-2<CR>==
  " inoremap mj <Esc>:m .+1<CR>==gi
  " inoremap mk <Esc>:m .-2<CR>==gi
  vnoremap mj :m '>+1<CR>gv=gv
  vnoremap mk :m '<-2<CR>gv=gv

  " Close the current buffer
  map <leader>bd :Bclose<cr>:tabclose<cr>gT

  " Close all the buffers
  map <leader>ba :bufdo bd<cr>

  map <leader>l :bnext<cr>
  map <leader>h :bprevious<cr>
  " Move a line of text using ALT+[jk]
  " nmap mj mz:m+<cr>`z
  " nmap mk mz:m-2<cr>`z
  " vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
  " vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
endif

