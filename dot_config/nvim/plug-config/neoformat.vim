let g:neoformat_try_formatprg = 1
let g:neoformat_enabled_json = ['jq']
let g:neoformat_enabled_lua = ['luaformatter']
let g:neoformat_enabled_python = ['black']

" Format on save
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
