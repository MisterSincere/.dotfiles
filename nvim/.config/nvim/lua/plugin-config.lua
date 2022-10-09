local setup = function()
-- allow rg to detect root of git
local executable = vim.fn['executable']
if executable('rg') then
  vim.g.rg_derive_root = 'true'
end

-- thing to ignore in search
vim.g.ctrlp_user_command = {'.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'}
vim.g.ctrlp_use_caching = 0

-- ycm options
vim.g.ycm_enable_diagnostic_highlighting = 1
vim.g.ycm_enable_diagnostic_signs = 0

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
	ensure_installed = { "c", "cpp" },
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

-- cokeline a bufferline
local get_hex = require('cokeline/utils').get_hex
local mappings = require('cokeline/mappings')

local comments_fg = get_hex('Comment', 'fg')
local errors_fg = get_hex('DiagnosticError', 'fg')
local warnings_fg = get_hex('DiagnosticWarn', 'fg')

local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_3

local components = {
  space = {
    text = ' ',
    truncation = { priority = 1 }
  },

  two_spaces = {
    text = '  ',
    truncation = { priority = 1 },
  },

  separator = {
    text = function(buffer)
      return buffer.index ~= 1 and '▏' or ''
    end,
    truncation = { priority = 1 }
  },

  devicon = {
    text = function(buffer)
      return
        (mappings.is_picking_focus() or mappings.is_picking_close())
          and buffer.pick_letter .. ' '
           or buffer.devicon.icon
    end,
    fg = function(buffer)
      return
        (mappings.is_picking_focus() and yellow)
        or (mappings.is_picking_close() and red)
        or buffer.devicon.color
    end,
    style = function(_)
      return
        (mappings.is_picking_focus() or mappings.is_picking_close())
        and 'italic,bold'
         or nil
    end,
    truncation = { priority = 1 }
  },

  index = {
    text = function(buffer)
      return buffer.index .. ': '
    end,
    truncation = { priority = 1 }
  },

  unique_prefix = {
    text = function(buffer)
      return buffer.unique_prefix
    end,
    fg = comments_fg,
    style = 'italic',
    truncation = {
      priority = 3,
      direction = 'left',
    },
  },

  filename = {
    text = function(buffer)
      return buffer.filename
    end,
    style = function(buffer)
      return
        ((buffer.is_focused and buffer.diagnostics.errors ~= 0)
          and 'bold,underline')
        or (buffer.is_focused and 'bold')
        or (buffer.diagnostics.errors ~= 0 and 'underline')
        or nil
    end,
    truncation = {
      priority = 2,
      direction = 'left',
    },
  },

  diagnostics = {
    text = function(buffer)
      return
        (buffer.diagnostics.errors ~= 0 and '  ' .. buffer.diagnostics.errors)
        or (buffer.diagnostics.warnings ~= 0 and '  ' .. buffer.diagnostics.warnings)
        or ''
    end,
    fg = function(buffer)
      return
        (buffer.diagnostics.errors ~= 0 and errors_fg)
        or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
        or nil
    end,
    truncation = { priority = 1 },
  },

  close_or_unsaved = {
    text = function(buffer)
      return buffer.is_modified and '●' or ''
    end,
    fg = function(buffer)
      return buffer.is_modified and green or nil
    end,
    delete_buffer_on_left_click = true,
    truncation = { priority = 1 },
  },
}

require('cokeline').setup({
  show_if_buffers_are_at_least = 2,

  buffers = {
	filter_valid = function(buffer) return buffer.filename ~= 'quickfix' and buffer.filename ~= '[dap-repl]' end,
    -- filter_valid = function(buffer) return buffer.type ~= 'terminal' end,
    -- filter_visible = function(buffer) return buffer.type ~= 'terminal' end,
    new_buffers_position = 'next',
  },

  rendering = {
    max_buffer_width = 30,
  },

  default_hl = {
    fg = function(buffer)
      return
        buffer.is_focused
        and get_hex('Normal', 'fg')
         or get_hex('Comment', 'fg')
    end,
    bg = get_hex('ColorColumn', 'bg'),
  },

  components = {
    components.space,
    components.separator,
    components.space,
    components.devicon,
    components.space,
    components.index,
    components.unique_prefix,
    components.filename,
    components.diagnostics,
    components.two_spaces,
    components.close_or_unsaved,
    components.space,
  },
})

end

return {
    setup = setup
}
