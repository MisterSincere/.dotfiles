local setup = function()
-- allow rg to detect root of git
local executable = vim.fn['executable']
if executable('rg') then
  vim.g.rg_derive_root = 'true'
end

-- thing to ignore in search
vim.g.ctrlp_user_command = {'.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'}
vim.g.ctrlp_use_caching = 0

-- gutentags
vim.g.gutentags_exclude_project_root = {'home/kaffeekind/programming/mtstudio/projects/*'}

-- gotoheader
vim.g.goto_header_associate_cpp_h = 1

-- telescope
local telescope_actions = require('telescope.actions')
local telescope = require('telescope')
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<F1>"] = telescope_actions.close,
        ["<ESC>"] = telescope_actions.close,
      }
    }
  }
})
telescope.load_extension('ui-select')

-- treesitter
local treesitter = require('nvim-treesitter.configs')
treesitter.setup({
	ensure_installed = { "help", "c", "cpp", "lua", "rust" },
	auto_install = true,
	highlight = {
		enable = true,
	}
})

-- dap debugger
local dap = require('dap')
dap.set_log_level('DEBUG')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = 'lldb',
}
dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
}
vim.fn.sign_define('DapBreakpoint', {text=' B', texthl='', linehl='', numhl=''})
dap.configurations.c = dap.configurations.cpp

-- dap virtual text extension
local dap_virt_text = require('nvim-dap-virtual-text')
dap_virt_text.setup({
	enabled = true,
  	enabled_commands = true,
  	highlight_changed_variables = true,
  	highligh_new_as_changed = false,
  	show_stop_reasons = true,
  	commented = false,
  	only_first_definition = true,
  	all_references = false,
  	filter_references_pattern = '<module',
  	-- there are experimental features
})

-- neovim-cmake
local Path = require('plenary.path')
vim.g.cmake_build_dir = 'build'
local cmake = require('cmake')
cmake.setup({
  cmake_executable = 'cmake',
  save_before_build = true,
  parameters_file = 'neovim.json',
  build_dir = tostring(Path:new('{cwd}', 'build-{build_type}/')),
  default_projects_path = tostring(Path:new(vim.loop.os_homedir(), 'programming')),
  configure_args = {'-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1'},
  build_args = {},
  on_build_output = nil,
  quickfix = {
	pos = 'botright',
	height = 10,
	only_on_error = false
  },
  copy_compile_commands = true,
  dap_configuration = {type = 'lldb', request = 'launch'},
  dap_open_command = dap.repl.open,
})

end

return {
    setup = setup
}
