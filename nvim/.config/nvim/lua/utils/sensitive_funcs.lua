-- utils/debug_functions.lua

local M = {}

-- generalized functions to check which "environment"
-- should be activated
local lang_sel = require('utils.lang_selection')

-- used for c / cpp
local dap = require('dap')
local dap_widgets = require('dap.ui.widgets')

local cur_hovers = {}

function M.toggle_breakpoint()
	if (lang_sel.is_c() or lang_sel.is_python()) then
		dap.toggle_breakpoint()
	end
end

function M.conditional_breakpoint()
	if (lang_sel.is_c()) then
		local cond = vim.fn.input('Breakpoint condition: ')
		dap.set_breakpoint(cond)
	end
end

function M.step_into()
	if (lang_sel.is_c() or lang_sel.is_python()) then
		dap.step_into()
	end
end

function M.step_over()
	if (lang_sel.is_c() or lang_sel.is_python()) then
		dap.step_over()
	end
end

function M.continue()
	if (lang_sel.is_c() or lang_sel.is_python()) then
		dap.continue()
	end
end

function M.show_dbg_value()
	if (lang_sel.is_c() or lang_sel.is_python()) then
		new_hover = dap_widgets.hover()
		table.insert(cur_hovers, new_hover)
	end
end

function M.close_dbg_value()
	if (#cur_hovers > 0) then
		cur_hovers[#cur_hovers].close()
		cur_hovers[#cur_hovers] = nil
	end
end

function M.build_all()
	if (lang_sel.is_c()) then
		vim.cmd('CMake build_all')
	elseif (lang_sel.is_rust()) then
		vim.cmd('!cargo build')
	end
end

function M.run()
	if (lang_sel.is_c()) then
		vim.cmd('CMake run')
	elseif (lang_sel.is_rust()) then
		vim.cmd('!cargo run')
	elseif (lang_sel.is_python()) then
		vim.cmd("!python %")
	end
end

function M.run_debug()
	if (lang_sel.is_c()) then
		vim.cmd('CMake build_and_debug')
	elseif (lang_sel.is_python()) then
		dap.continue()
	end
end

function M.format()
	if (lang_sel.is_c()) then
		vim.cmd('ClangFormat') 
	elseif (lang_sel.is_rust()) then
		vim.cmd('RustFmt')
	end
end

function M.goto_definition()
	if (lang_sel.is_c()) then
		vim.cmd('YcmCompleter GoTo')
	elseif (lang_sel.is_rust()) then
		--vim.cmd('ALEGoToDefinition')
	end
end

return M
