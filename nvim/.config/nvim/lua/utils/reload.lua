-- utils/reload.lua

local M = {}

local P = function(v)
  print(vim.inspect(v))
  return v
end

local RELOAD = require("plenary.reload").reload_module

local R = function(name)
  RELOAD(name)
  local setup = require(name).setup
  if setup~=nil then setup() end
end



function M.reload()
  -- Telescope will give us something like ju/colors.lua,
  -- so this function converts the selected entry to
  -- the module name: ju.colors
  local function get_module_name(s)
    local module_name;

    module_name = s:gsub("%.lua", "")
    module_name = module_name:gsub(".*%/lua/", "")
    module_name = module_name:gsub("%/", ".")

    return module_name
  end

  local prompt_title = "~ neovim modules ~"

  -- sets the path to the lua folder
  local path = "~/.config/nvim"

  local opts = {
    prompt_title = prompt_title,
    cwd = path,

    attach_mappings = function(_, map)
      -- Adds a new map to ctrl+e
      map("i", "<c-e>", function(_)
        local entry = require("telescope.actions.state").get_selected_entry()
        local name = get_module_name(entry.value)

        -- call the helper method to reload the module
        -- and give some feedback
        R(name)
        P(name .. " RELOADED!!!")
      end)

      return true
    end
  }

  -- call the builtin method to list files
  require('telescope.builtin').find_files(opts)
end

return M;
