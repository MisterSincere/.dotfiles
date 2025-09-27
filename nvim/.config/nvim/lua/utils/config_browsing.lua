-- utils/config_browsing.lua

local M = {}

function M.show_nvim_config_files()
    local opts = {
	prompt_title = "~ neovim modules ~",
	cwd = "~/.config/nvim",
	follow = true,
	file_ignore_patterns = { "plugged/" },
    }

    require('telescope.builtin').find_files(opts)
end

return M;
