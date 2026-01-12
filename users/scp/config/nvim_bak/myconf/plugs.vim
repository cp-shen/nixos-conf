call plug#begin()

Plug 'scrooloose/nerdtree'
    "bind key to toggle NERDTree
    nnoremap <A-1> :NERDTreeFocus<CR>
    nnoremap <A-2> :NERDTreeToggle<CR>

Plug 'itchyny/lightline.vim'
let g:lightline = {
    \ 'colorscheme': 'spacegray',
    \ 'active': {
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'clock', 'fileformat', 'fileencoding', 'filetype', ] ]
    \ },
    \ 'component_function': {
    \   'clock': 'ShowCurTime'
    \ },
    \ }
function! ShowCurTime()
    return strftime('%H:%M')
endfunction

Plug 'navarasu/onedark.nvim'
let g:onedark_config = {
    \ 'style': 'dark',
\}

Plug 'LnL7/vim-nix'

call plug#end()

