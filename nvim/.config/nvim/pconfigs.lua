local vim = vim

-- allow rg to detect root of git
local executable = vim.fn['executable']
if executable('rg') then
    vim.g.rg_derive_root = 'true'
end

-- thing to ignore in search
vim.g.ctrlp_user_command = {'.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'}
vim.g.ctrlp_use_caching = 0

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

