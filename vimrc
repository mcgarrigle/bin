syntax on
filetype plugin indent on

set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab

" set ai
" set si
" au BufNewFile,BufRead *.etl set filetype=ruby
" au BufNewFile,BufRead *.dsl set filetype=ruby

autocmd BufNewFile,BufRead *.lab set filetype=ruby

" have vim jump to the last position when reopening a file
" if you have problems check the ownership/permissions of ~/.viminfo

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" commits set spell and width

autocmd Filetype gitcommit setlocal spell textwidth=72

" puppet settings

autocmd BufNewFile,BufRead *.pp set filetype=puppet
autocmd BufWritePre *.pp :%s/\s\+$//e
autocmd Filetype puppet setlocal textwidth=70
" autocmd Filetype puppet setlocal syntax on

set background=dark

set dictionary=/usr/share/dict/words

" use ^X^U

fun! CompleteMonths(findstart, base)
  if a:findstart
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start
  else
    " find months matching with "a:base"
    let res = []
    let s = system("~/.vim/fields")
    " for m in split("foopfoofoo Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec")
    for m in split(s)
      if m =~ '^' . a:base
        call add(res, m)
      endif
    endfor
    return res
  endif
endfun
set completefunc=CompleteMonths
