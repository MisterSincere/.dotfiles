-- config/autocmds.lua
local function augroup(name)
    return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- keybindings during netrw
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("netrw_keybinds"),
    callback = function()
	vim.keymap.set(
	    "n", "<F1>",
	    function() require("utils.config_browsing").reload() end,
	    { buffer = true, noremap = true, silent = true }
	)
    end,
})

-- when opening buffer go to last cursor location
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(event)
	local exclude = { "gitcommit" }
	local buf = event.buf
	if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].custom_last_loc then
	    return
	end
	vim.b[buf].custom_last_loc = true
	local mark = vim.api.nvim_buf_get_mark(buf, '"')
	local lcount = vim.api.nvim_buf_line_count(buf)
	if mark[1] > 0 and mark[1] <= lcount then
	    pcall(vim.api.nvim_win_set_cursor, 0, mark)
	end
    end,
})

-- TODO: The following are autocmds from the autocommands.vim
-- when needed convert to new lua format
--autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
--autocmd FileType python map <buffer> <F10> :w<CR>:exec '!python' shellescape(@%, 1)
--autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>
--autocmd FileType c setlocal foldmethod=syntax
--au FileType python setlocal formatprg=autopep8\ -
