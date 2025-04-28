local function map(mode, combo, mapping, opts)
	local options = {noremap = true}
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.keymap.set(mode, combo, mapping, options)
end

local function imap(combo, mapping, opts)
	map('i', combo, mapping, opts)
end

local function nmap(combo, mapping, opts)
	map('n', combo, mapping, opts)
end

local function xmap(combo, mapping, opts)
	map('x', combo, mapping, opts)
end

local function vmap(combo, mapping, opts)
	map('v', combo, mapping, opts)
end

local lang_sel = require('utils.lang_selection')

-- key to enter command mode
vim.g.mapleader = " "
vim.g.maplocalleader = " "

imap('jk', '<ESC>')

nmap('<leader>gh', ':diffget //3<CR>')
nmap('<leader>gu', ':diffget //2<CR>')
nmap('<leader>gs', ':G<CR>')

nmap('<leader>e', ':Explore<CR>')

-- keypress do disable search result highlighting
nmap('<leader>n', ':nohlsearch<CR>', {silent=true})

-- redo command
nmap('<leader>r', ':redo<CR>')

-- buffer commands
nmap('gn', ':bn<CR>')
nmap('gp', ':bp<CR>')

-- save and close commands with leader
nmap('<leader>s', ':w<CR>')
nmap('<leader>q', ':q<CR>')

-- undotree
nmap('<leader>u', vim.cmd.UndotreeToggle)

-- resizing with leader
nmap('<leader>=', ':vertical resize +5<CR>', {silent=true})
nmap('<leader>-', ':vertical resize -5<CR>', {silent=true})

-- tpopes fugitive
nmap('<leader>gs', vim.cmd.Git)

-- show nvim configs / reload configs
nmap('<F1>', '<cmd>:lua require("utils.reload").reload()<CR>', {silent=true,noremap=false})

-- file browsing (telescope)
local telescope_builtin = require('telescope.builtin')
nmap('<leader>pv', '<cmd>:lua require("utils.file_browsing").project_view()<CR>', {silent=true})
nmap('<leader>ps', '<cmd>:lua require("utils.file_browsing").project_search()<CR>', {silent=true})
nmap('<leader><leader>', telescope_builtin.tags, {silent=true})

-- harpoon
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
nmap('<leader>ha', mark.add_file)
nmap('<leader>hh', ui.toggle_quick_menu)
for i=1,9 do
	nmap(('<leader>%s'):format(i), function() ui.nav_file(i) end)
end

-- gotoheader
nmap('<F12>', ':GotoHeader<CR>')
imap('<F12>', '<ESC>:GotoHeader<CR>')
nmap('<leader>gh', ':GotoHeaderSwitch<CR>')

-- cmake building
nmap('<C-t>', ':CMake select_target<CR>')
nmap('<C-d>', ':CMake select_build_type<CR>')
nmap('<C-c>', ':CMake configure<CR>')
nmap('<C-b>', ':lua require \'utils.sensitive_funcs\'.build_all()<CR>')
nmap('<C-Shift-b>', ':lua require \'utils.sensitive_funcs\'.build()<CR>')
nmap('<C-a>', ':lua require \'utils.sensitive_funcs\'.set_run_args()<CR>')
nmap('<leader><F5>', ':lua require\'utils.sensitive_funcs\'.run_debug()<CR>', {silent=false})
nmap('<F5>', ':lua require\'utils.sensitive_funcs\'.run()<CR>')

-- debugging
nmap('<F9>', ':lua require\'utils.sensitive_funcs\'.toggle_breakpoint()<CR>')
nmap('<leader><F9>', ':lua require\'utils.sensitive_funcs\'.conditional_breakpoint()<CR>')
nmap('<F6>', ':lua require\'utils.sensitive_funcs\'.step_into()<CR>')
nmap('<F7>', ':lua require\'utils.sensitive_funcs\'.step_over()<CR>')
nmap('<F8>', ':lua require\'utils.sensitive_funcs\'.continue()<CR>')
nmap('<F10>', ':lua require\'utils.sensitive_funcs\'.show_dbg_value()<CR>', {silent=false})
nmap('<F11>', ':lua require\'utils.sensitive_funcs\'.close_dbg_value()<CR>', {silent=false})

-- remote sshfs
local rsshfs = require('remote-sshfs.api')
nmap('<leader>rc', rsshfs.connect)
nmap('<leader>rd', rsshfs.disconnect)
nmap('<leader>re', rsshfs.edit)

-- diagnostics
nmap('<leader>d', vim.diagnostic.open_float)

-- formatting shortcut
vmap('<leader>f',
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
xmap('p', "\"_dP")
