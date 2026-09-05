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
	    function() require("utils.config_browsing").show_nvim_config_files() end,
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

vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    group = vim.api.nvim_create_augroup("Rust_disable_single_quote", { clear = true }),
    callback = function()
	-- mini.pairs always adds a second of ', " etc. this is bad in rust for lifetime specifier symbol: '. This should disable this!
	MiniPairs.unmap("i", "'", "''")

	-- somehow closing brackets for () don't get reindented correctly (in rust at least) by mini.pairs
	-- this should fix it
	--vim.keymap.set("i", "<CR>", function()
	--    local cursor = vim.api.nvim_win_get_cursor(0)
	--    local row, col = cursor[1], cursor[2]
	--    local line = vim.api.nvim_get_current_line()

	--    if line:sub(col, col) == "(" and line:sub(col + 1, col + 1) == ")" then
	--	local buf = vim.api.nvim_get_current_buf()
	--	local win = vim.api.nvim_get_current_win()

	--	vim.schedule(function()
	--	    if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then
	--		return
	--	    end

	--	    -- mini.pairs places the original `)` two lines below the opening line.
	--	    local close_row = row + 2
	--	    local close_line = vim.api.nvim_buf_get_lines(buf, close_row - 1, close_row, false)[1] or ""

	--	    if close_line:match("^%s*%)") then
	--		local restore_cursor = vim.api.nvim_win_get_cursor(win)

	--		vim.api.nvim_win_call(win, function()
	--		    vim.cmd("keepjumps " .. close_row .. "normal! ==")
	--		end)

	--		vim.api.nvim_win_set_cursor(win, restore_cursor)
	--	    end
	--	end)
	--    end

	--    return MiniPairs.cr()
	--end, {
	--    buffer = true,
	--    expr = true,
	--    replace_keycodes = false,
	--    desc = "MiniPairs Enter with Rust paren indentation",
	--})
    end,
    desc = "Disable single quote Rust",
})


-- TODO: The following are autocmds from the autocommands.vim
-- when needed convert to new lua format
--autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
--autocmd FileType python map <buffer> <F10> :w<CR>:exec '!python' shellescape(@%, 1)
--autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>
--autocmd FileType c setlocal foldmethod=syntax
--au FileType python setlocal formatprg=autopep8\ -
