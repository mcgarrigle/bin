syntax on
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
" set ai
" set si
" au BufNewFile,BufRead *.etl set filetype=ruby
" au BufNewFile,BufRead *.dsl set filetype=ruby

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
