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
au BufNewFile,BufRead *.lab set filetype=ruby

" have vim jump to the last position when reopening a file
" if you have problems check the ownership/permissions of ~/.viminfo

if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  autocmd Filetype gitcommit setlocal spell textwidth=72
endif
