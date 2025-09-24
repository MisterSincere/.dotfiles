-- config/keybindings.lua

local map = require("utils.keymap")
local lang_sel = require("utils.lang_selection")

map.i("jk", "<ESC>")
map.n("<leader>n", ":nohlsearch<CR>", {silent=true})
map.n("<leader>r", ":redo<CR>")
map.n("<leader>cs", ":setlocal spell spelllang=en_us<CR>")
map.n("<leader>s", ":w<CR>")
map.n("<leader>q", ":q<CR>")
map.n("<leader>=", ":vertical resize +5<CR>", {silent=true})
map.n("<leader>-", ":vertical resize -5<CR>", {silent=true})
map.n("<F1>", require("utils.config_browsing").show_nvim_config_files, {silent=true,noremap=false})
map.n("<F2>", ":Mason<CR>", {silent=true,noremap=false})
--map.n("gn", ":bn<CR>")
--map.n("gp", ":bp<CR>")

-- cmake building
map.n("<C-t>", ":CMake select_target<CR>")
map.n("<C-d>", ":CMake select_build_type<CR>")
map.n("<C-c>", ":CMake configure<CR>")
map.n("<C-b>", require("utils.sensitive_funcs").build_all)
--map.n("<C-Shift-b>", require("utils.sensitive_funcs").build)
map.n("<C-a>", require("utils.sensitive_funcs").set_run_args)
map.n("<leader><F5>", require("utils.sensitive_funcs").run_debug, {silent=false})
map.n("<F5>", require("utils.sensitive_funcs").run)

-- debugging
map.n("<F9>", require("utils.sensitive_funcs").toggle_breakpoint)
map.n("<leader><F9>", require("utils.sensitive_funcs").conditional_breakpoint)
map.n("<F6>", require("utils.sensitive_funcs").step_into)
map.n("<F7>", require("utils.sensitive_funcs").step_over)
map.n("<F8>", require("utils.sensitive_funcs").continue)
map.n("<F10>", require("utils.sensitive_funcs").show_dbg_value, {silent=false})
map.n("<F11>", require("utils.sensitive_funcs").close_dbg_value, {silent=false})


-- formatting shortcut
map.v("<leader>f",
function ()
	if (lang_sel.is_c()) then
		vim.cmd("ClangFormat")
	elseif (lang_sel.is_rust()) then
		vim.cmd("RustFmt")
	end
end
,
{ silent = true }
)

-- dont overwrite copy register
map.x("p", "\"_dP")
