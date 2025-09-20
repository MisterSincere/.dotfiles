-- utils/project_view.lua

local M = {}

local telescope_builtin = require('telescope.builtin')

function M.project_view()
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
			'-e', '.lua',
			'-e', '.vim',
			'-e', '.qml',
			'-e', '.desktop',
			'-e', '.cu',
			'-e', '.txt',
			'-e', '.php',
			'-e', '.twig',
			'-e', '.cmake',
			'-e', '.py',
			'-e', '.comp',
			'-e', '.conf',
			'-e', '.typ',
			'-e', '.yaml',
			'-e', '.bib',
			'-e', '.yml',
			'-e', '.glsl',
			'-e', '.vert',
			'-e', '.frag',
			'-e', '.geom',
			'-e', '.prj',
			'-e', '.prjinc',
			'-e', '.rg',
			'-e', '.json',
			'-e', '.js',
			'-e', '.ts',
			'-e', '.css',
			'-e', '.scss',
			'-e', '.yaml',
			'-e', '.gitignore',
			'-e', '.rs',
			'-e', '.toml',
			'-e', '.vue',
			'-e', '.html',
			'-e', '.twig',
			'-e', '.yml',
			'-e', 'lib/vkrenderer',
			'--exclude', 'var',
			'--exclude', 'vendor',
			'--exclude', 'bin',
			'--exclude', 'lib',
			'--exclude', 'lib/vkrenderer/libs',
			'--exclude', 'build-debug',
			'--exclude', 'build-release',
			'--exclude', 'vendor',
			'--exclude', 'node_modules',
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


	telescope_builtin.find_files(opts)
end

function M.project_search()
	telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") });
end

return M
