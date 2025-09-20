return {
    -- debugging
    { 
	"mfussenegger/nvim-dap",
	config = function(lazy, props)
	    local dap = require("dap")
	    dap.set_log_level("DEBUG")
	    dap.adapters.lldb = {
		type = "executable",
		command = "/usr/bin/lldb-vscode",
		name = "lldb",
	    }
	    dap.configurations.cpp = {
		{
		    name = "Launch",
		    type = "lldb",
		    request = "launch",
		    program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		    end,
		    cwd = "${workspaceFolder}",
		    stopOnEntry = false,
		    args = {},
		    runInTerminal = false,
		}
	    }
	    dap.configurations.c = dap.configurations.cpp
	    vim.fn.sign_define('DapBreakpoint', {
		text = " B", texthl = "", linehl = "", numhl = ""
	    })
	end,
    },
    {
	"theHamsta/nvim-dap-virtual-text",
	props = {
	    enabled = true,
	    enabled_commands = true,
	    highlight_changed_variables = true,
	    highlight_new_as_changed = false,
	    show_stow_reasons = true,
	    commented = false,
	    only_first_definition = true,
	    all_references = false,
	    filter_references_pattern = "<module",
	},
    },
}
