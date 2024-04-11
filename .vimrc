syntax on

au BufRead,BufNewFile *.t set filetype=perl
au BufRead *.lib set filetype=perl

set expandtab
set tabstop=4
set shiftwidth=4
set number
set incsearch
set spell
set colorcolumn=80
set foldmethod=indent
set foldlevel=99
set updatetime=100

nnoremap <space> za

autocmd FileType gitcommit set textwidth=120
autocmd FileType gitcommit set colorcolumn=121
filetype plugin indent on
