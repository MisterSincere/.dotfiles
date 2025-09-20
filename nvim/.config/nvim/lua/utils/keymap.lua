local M = {}

local function map(mode, combo, mapping, opts)
	local options = {noremap = true}
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.keymap.set(mode, combo, mapping, options)
end

function M.i(combo, mapping, opts)
	map('i', combo, mapping, opts)
end

function M.n(combo, mapping, opts)
	map('n', combo, mapping, opts)
end

function M.x(combo, mapping, opts)
	map('x', combo, mapping, opts)
end

function M.v(combo, mapping, opts)
	map('v', combo, mapping, opts)
end

return M
