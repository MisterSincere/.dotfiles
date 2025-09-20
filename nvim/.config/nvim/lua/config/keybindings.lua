-- config/keybindings.lua

local map = require("utils.keymap")
local lang_sel = require("utils.lang_selection")

map.i('jk', '<ESC>')
map.n('<leader>n', ':nohlsearch<CR>', {silent=true})
map.n('<leader>r', ':redo<CR>')
map.n('<leader>cs', ':setlocal spell spelllang=en_us<CR>')
map.n('<leader>s', ':w<CR>')
map.n('<leader>q', ':q<CR>')
map.n('<leader>=', ':vertical resize +5<CR>', {silent=true})
map.n('<leader>-', ':vertical resize -5<CR>', {silent=true})
map.n('<leader>d', vim.diagnostic.open_float)
map.n('<F1>', require("utils.config_browsing").reload, {silent=true,noremap=false})
--map.n('gn', ':bn<CR>')
--map.n('gp', ':bp<CR>')

-- cmake building
map.n('<C-t>', ':CMake select_target<CR>')
map.n('<C-d>', ':CMake select_build_type<CR>')
map.n('<C-c>', ':CMake configure<CR>')
map.n('<C-b>', ':lua require \'utils.sensitive_funcs\'.build_all()<CR>')
map.n('<C-Shift-b>', ':lua require \'utils.sensitive_funcs\'.build()<CR>')
map.n('<C-a>', ':lua require \'utils.sensitive_funcs\'.set_run_args()<CR>')
map.n('<leader><F5>', ':lua require\'utils.sensitive_funcs\'.run_debug()<CR>', {silent=false})
map.n('<F5>', ':lua require\'utils.sensitive_funcs\'.run()<CR>')

-- debugging
map.n('<F9>', ':lua require\'utils.sensitive_funcs\'.toggle_breakpoint()<CR>')
map.n('<leader><F9>', ':lua require\'utils.sensitive_funcs\'.conditional_breakpoint()<CR>')
map.n('<F6>', ':lua require\'utils.sensitive_funcs\'.step_into()<CR>')
map.n('<F7>', ':lua require\'utils.sensitive_funcs\'.step_over()<CR>')
map.n('<F8>', ':lua require\'utils.sensitive_funcs\'.continue()<CR>')
map.n('<F10>', ':lua require\'utils.sensitive_funcs\'.show_dbg_value()<CR>', {silent=false})
map.n('<F11>', ':lua require\'utils.sensitive_funcs\'.close_dbg_value()<CR>', {silent=false})


-- formatting shortcut
map.v('<leader>f',
function ()
	if (lang_sel.is_c()) then
		vim.cmd('ClangFormat')
	elseif (lang_sel.is_rust()) then
		vim.cmd('RustFmt')
	end
end
,
{ silent = true }
)

-- dont overwrite copy register
map.x('p', "\"_dP")
