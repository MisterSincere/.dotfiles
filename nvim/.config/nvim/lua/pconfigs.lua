local vim = vim

-- allow rg to detect root of git
local executable = vim.fn['executable']
if executable('rg') then
  vim.g.rg_derive_root = 'true'
end

-- copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- thing to ignore in search
vim.g.ctrlp_user_command = {'.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'}
vim.g.ctrlp_use_caching = 0

-- gutentags
vim.g.gutentags_exclude_project_root = {'home/kaffeekind/programming/mtstudio/projects/*'}
vim.g.gutentags_cache_dir = os.getenv('HOME') .. '/.cache/gutentags/'
vim.g.gutentags_ctags_exclude = {
		'.idea/*',
		'*.git',
		'*.svg',
		'*.hg',
		'*/tests/*',
		'build',
		'dist',
		'bin',
		'node_modules',
		'cache',
		'compiled',
		'docs',
		'example',
		'vendor',
		'*.md',
		'*-lock.json',
		'*.min.*',
		'*.bak',
		'*.pyc',
		'*.class',
		'*.tmp',
		'*.cache',
		'tags*',
		'*.mp3',
		'*.ogg',
		'*.flac',
		'*.swp',
		'*.bmp',
		'*.gif',
		'*.ico',
		'*.jpg',
		'*.png',
		'*.rar',
		'*.zip',
		'*.tar',
		'*.tar.gz',
		'*.tar.xz',
		'*.tar.bz2',
		'*.pdf',
		'*.json',
}

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
		ensure_installed = { "lua" },
		auto_install = true,
		highlight = {
				enable = true,
		},
		indent = {
				enable = true,
		}
})

-- lsp
require('lsp-config')

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

-- remote sshfs
local remote_sshfs = require('remote-sshfs')
remote_sshfs.setup{
  connections = {
    ssh_configs = { -- which ssh configs to parse for hosts list
      vim.fn.expand "$HOME" .. "/.ssh/config",
      "/etc/ssh/ssh_config",
      -- "/path/to/custom/ssh_config"
    },
    sshfs_args = { -- arguments to pass to the sshfs command
      "-o reconnect",
      "-o ConnectTimeout=5",
    },
  },
  mounts = {
    base_dir = vim.fn.expand "$HOME" .. "/.sshfs/", -- base directory for mount points
    unmount_on_exit = true, -- run sshfs as foreground, will unmount on vim exit
  },
  handlers = {
    on_connect = {
      change_dir = true, -- when connected change vim working directory to mount point
    },
    on_disconnect = {
      clean_mount_folders = false, -- remove mount point folder on disconnect/unmount
    },
    on_edit = {}, -- not yet implemented
  },
  ui = {
    select_prompts = false, -- not yet implemented
    confirm = {
      connect = false, -- prompt y/n when host is selected to connect to
      change_dir = false, -- prompt y/n to change working directory on connection (only applicable if handlers.on_connect.change_dir is enabled)
    },
  },
  log = {
    enable = false, -- enable logging
    truncate = false, -- truncate logs
    types = { -- enabled log types
      all = false,
      util = false,
      handler = false,
      sshfs = false,
    },
  },
}
--local remote_sshfs_connections = require('remote-sshfs.connections')
--remote_sshfs_connections.list_hosts()["ICG"]["Path"] = "/afs/cg.cs.tu-bs.de/home/heesen/"
--require('telescope').load_extension('remote-sshfs')

require('nvim-highlight-colors').setup({})

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require("typst-preview").setup({
	debug = true,
	port = 33465,
	dependencies_bin = {
		['tinymist'] = 'tinymist',
	},
})
