-- config/keybindings.lua

local map = require("utils.keymap")
local lang_sel = require("utils.lang_selection")
local tf = require("utils.smart_tagfunc")

-- my own smart tag func
map.n("<C-]>", tf.call, {
    silent = true,
    desc = "",
})

map.i("jk", "<ESC>")
map.n("<leader>h", ":wincmd h<CR>", {silent=true})
map.n("<leader>l", ":wincmd l<CR>", {silent=true})
map.n("<leader>j", ":wincmd j<CR>", {silent=true})
map.n("<leader>k", ":wincmd k<CR>", {silent=true})
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
--map.n("<C-t>", ":CMake select_target<CR>")
map.n("<C-d>", ":CMakeSelectBuildType<CR>")
map.n("<C-c>", ":CMakeGenerate<CR>")
map.n("<C-Shift-b>", require("utils.sensitive_funcs").build_all)
map.n("<C-b>", require("utils.sensitive_funcs").build)
map.n("<C-a>", require("utils.sensitive_funcs").set_run_args)
map.n("<C-t>", require("utils.sensitive_funcs").set_launch_target)
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

-- neogen
map.n("<leader>df", ":lua require('neogen').generate({ type='func' })<CR>");
map.n("<leader>dc", ":lua require('neogen').generate({ type='class' })<CR>");


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
