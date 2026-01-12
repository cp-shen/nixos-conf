" folding
nnoremap z- zm
nnoremap z= zr
nnoremap zz za

"set key to show full path
nnoremap <A-3> :echo expand('%:p')<CR>

"save file
nnoremap <C-s> :w<CR>

"set Leader key
map <Space> <Leader>

"reload file if changed by other program
nnoremap <Leader>ct :checktime<CR>

"reload config file
nnoremap <Leader>so :so $MYVIMRC<CR>

function! s:load_ginit()
    execute "source" stdpath('config')."/ginit.vim"
endfunction
nnoremap <Leader>gso :call <SID>load_ginit()<CR>

nnoremap <Leader>nh :noh<CR>

nnoremap <Leader>j i<CR><Esc>

nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

