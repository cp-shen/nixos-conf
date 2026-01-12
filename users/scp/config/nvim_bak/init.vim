" lang and encoding
set langmenu=en_US
set encoding=utf-8

set ruler
set number
set showcmd
set nowrap
set showmatch
set showtabline=1
set background=dark
set mouse=a
set title
set hidden
set signcolumn=auto
set belloff=all
set cursorline

" guioptions
set guioptions-=T
set guioptions-=r
set guioptions-=L

" 1 tab as 4 spaces
set tabstop=4 shiftwidth=4 expandtab

" searching
set hlsearch
set ignorecase
set smartcase

" fold:
set foldcolumn=0
set foldignore=
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" if isdirectory(expand("~/.vim"))
"     set packpath+=~/.vim,
" endif
" if filereadable(expand("~/.vimrc"))
"     source ~/.vimrc
" endif

let s:conf_dir=stdpath('config')."/myconf/"
execute "source" s:conf_dir . "plugs.vim"
execute "source" s:conf_dir . "keys.vim"
execute "source" s:conf_dir . "color.vim"

