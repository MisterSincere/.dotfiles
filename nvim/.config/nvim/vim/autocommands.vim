" execute current python file
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType python map <buffer> <F10> :w<CR>:exec '!python' shellescape(@%, 1)
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType c setlocal foldmethod=syntax
au FileType python setlocal formatprg=autopep8\ -

" jump to last position after reopening
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

