" execute current python file
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType python map <buffer> <F10> :w<CR>:exec '!python' shellescape(@%, 1)
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType c setlocal foldmethod=syntax
au FileType python setlocal formatprg=autopep8\ -

augroup netrw_keybinds
		autocmd!
		autocmd filetype netrw call Add_netrw_keybinds()
augroup END
function! Add_netrw_keybinds()
		noremap <buffer> <F1> <cmd>:lua require('utils.config_browsing').reload()<CR>
endfunction

" jump to last position after reopening
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

