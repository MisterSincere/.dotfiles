local M = {}

local api = vim.api

local function get_normal_wins()
    local wins = api.nvim_tabpage_list_wins(0)
    local normal_wins = {}
    for _, w in ipairs(wins) do
	local cfg = api.nvim_win_get_config(w)
	if cfg == nil or cfg.relative == "" then
	    table.insert(normal_wins, w)
	end
    end
    return normal_wins
end

local function extract_left_and_rightmost(windows)
    local left_win, leftmost_x = windows[1], nil
    local right_win, rightmost_x = windows[1], nil

    for _, w in ipairs(windows) do
	local pos = api.nvim_win_get_position(w)
	local width = api.nvim_win_get_width(w)
	local left_x = pos[2]
	local right_x = left_x + width - 1
	if leftmost_x == nil or left_x < leftmost_x then
	    leftmost_x = left_x
	    left_win = w
	end
	if rightmost_x == nil or right_x > rightmost_x then
	    rightmost_x = right_x
	    right_win = w
	end
    end

    return left_win, right_win
end

function M.ensure_right_split()
    local windows = get_normal_wins()

    if #windows == 0 then
	vim.cmd("vsplit")
	return
    end

    -- if current window is floating, switch to the first normal window
    local cur = api.nvim_get_current_win()
    local cur_cfg = api.nvim_win_get_config(cur)
    if cur_cfg and cur_cfg.relative ~= "" then
	api.nvim_set_current_win(windows[1])
	cur = windows[1]
    end

    -- compute leftmost (min col) and rightmost (max col+width-1) windows
    local left_win, right_win = extract_left_and_rightmost(windows)

    if left_win == right_win then
	vim.cmd("vsplit")
    else
	api.nvim_set_current_win(right_win)
    end
end

function M.ensure_left_split()
    local windows = get_normal_wins()

    if #windows == 0 then
	return
    end

    -- if current window is floating, switch to the first normal window
    local cur = api.nvim_get_current_win()
    local cur_cfg = api.nvim_win_get_config(cur)
    if cur_cfg and cur_cfg.relative ~= "" then
	api.nvim_set_current_win(windows[1])
	cur = windows[1]
    end

    -- compute leftmost (min col) and rightmost (max col+width-1) windows
    local left_win, _ = extract_left_and_rightmost(windows)

    api.nvim_set_current_win(left_win)
end

return M
