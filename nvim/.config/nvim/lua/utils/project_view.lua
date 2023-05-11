-- utils/project_view.lua

local M = {}


function M.view()
  local prompt_title = vim.fn.expand('%:t:r')

  local opts = {
    prompt_title = prompt_title,
    no_ignore = true,
    -- fd --type f --strip-cwd-prefix -I -e .h -e .cpp -e .cu -e .txt -e .cmake -e .comp -e .glsl -e .vert -e .frag -e .geom -e .prj -e .rg --exclude lib --exclude build
    find_command = {
      'fd',
      '--type', 'f',
      '--strip-cwd-prefix',
      '-e', '.h',
      '-e', '.cpp',
      '-e', '.cu',
      '-e', '.txt',
      '-e', '.cmake',
      '-e', '.comp',
      '-e', '.glsl',
      '-e', '.vert',
      '-e', '.frag',
      '-e', '.geom',
      '-e', '.prj',
	  '-e', '.prjinc',
      '-e', '.rg',
      '-e', '.json',
	  '-e', '.gitignore',
	  '-e', '.rs',
	  '-e', '.toml',
	  '-e', 'lib/vkrenderer',
      '--exclude', 'lib',
	  '--exclude', 'lib/vkrenderer/libs',
      '--exclude', 'build-debug',
      '--exclude', 'build-release',
      '--exclude', 'cmake-build-debug',
      '--exclude', 'cmake-build-release',
      '--exclude', 'build',
    },

    attach_mappings = function(_, map)
      -- Adds a new map to ctrl+e
      map("i", "<C-v>", function(_)
        local entry = require("telescope.actions.state").get_selected_entry()
        
        vim.cmd(":wincmd v")
        vim.cmd(":e " .. entry.value)
      end)
      map("i", "<C-h>", function(_)
        local entry = require("telescope.actions.state").get_selected_entry()
        
        vim.cmd(":wincmd h")
        vim.cmd(":e " .. entry.value)
      end)
      map("i", "<C-l>", function(_)
        local entry = require("telescope.actions.state").get_selected_entry()
        
        vim.cmd(":wincmd l")
        vim.cmd(":e " .. entry.value)
      end)

      return true
    end
  }

  -- call the builtin method to list files
  require('telescope.builtin').find_files(opts)
end

return M
