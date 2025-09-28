-- utils/smart_tagfunc.lua

local M = {}

local function call_tagfunc(pattern)
    local flags = "c"
    local info = {
	buf_ffname = vim.api.nvim_buf_get_name(0)
    }
    local res
    if vim.go.tagfunc ~= "" then
	res = vim.fn.call(vim.go.tagfunc, {pattern, flags, info})
    else
	res = vim.fn.taglist(pattern)
    end
    if not res or vim.tbl_isempty(res) then
	print("Tag not found: " .. pattern)
	return nil
    end
    return res
end

local function push_tagstack(pattern)
    local winid = vim.api.nvim_get_current_win()
    local ts = vim.fn.gettagstack(winid)
    table.insert(ts.items, {
	tagname = pattern,
	from = {
	    vim.api.nvim_get_current_buf(),
	    unpack(vim.api.nvim_win_get_cursor(winid))
	}
    })
    vim.fn.settagstack(winid, ts, 'r')
end

function M.call()
    local pattern = vim.fn.expand("<cword>")

    local res = call_tagfunc(pattern)
    if not res then return end

    push_tagstack(pattern)

    local tag = res[1]
    local target_file = vim.fn.fnamemodify(tag.filename, ":p")
    local target_line = tonumber(tag.cmd) or 1

    for _, win in ipairs(vim.api.nvim_list_wins()) do
	local buf = vim.api.nvim_win_get_buf(win)
	local bufname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":p")
	if bufname == target_file then
	    vim.api.nvim_set_current_win(win)
	    vim.api.nvim_win_set_cursor(win, { target_line, 0 })
	    return
	end
    end

    vim.cmd("edit " .. vim.fn.fnameescape(target_file))
    vim.api.nvim_win_set_cursor(0, { target_line, 0})
end

return M
