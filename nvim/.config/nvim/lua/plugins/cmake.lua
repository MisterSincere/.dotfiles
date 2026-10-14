-- old cmake setup
---- neovim-cmake
--local Path = require('plenary.path')
--vim.g.cmake_build_dir = 'build'
--local cmake = require('cmake')
--cmake.setup({
--    save_before_build = true,
--    parameters_file = 'neovim.json',
--    default_projects_path = tostring(Path:new(vim.loop.os_homedir(), 'programming')),
--    on_build_output = nil,
--    quickfix = {
--	pos = 'botright',
--	height = 10,
--	only_on_error = false
--    },
--    copy_compile_commands = true,
--    dap_configuration = {type = 'lldb', request = 'launch'},
--    dap_open_command = dap.repl.open,
--})

return {
    "Civitasv/cmake-tools.nvim",
    enabled = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
	local osys = require("cmake-tools.osys")
	local cmake = require("cmake-tools")
	cmake.setup({
	    cmake_executable = "cmake",
	    ctest_command = "ctest",
	    ctest_show_labels = false,
	    cmake_use_preset = true,
	    cmake_regenerate_on_save = true,
	    cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
	    cmake_build_options = {},
	    cmake_build_directory = function()
		if osys.iswin32 then
		    return "out\\${variant:buildType}"
		end
		return "out/${variant:buildType}"
	    end,
	    cmake_compile_commands_options = {
		action = "soft_link",
		target = vim.loop.cwd,
	    },
	    cmake_kits_path = nil,
	    cmake_variants_message = {
		short = { show = true },
		long = { show = true, max_length = 40 },
	    },
	    cmake_dap_configuration = {
		name = "cpp",
		type = "lldb",
		request = "launch",
		stopOnEntry = false,
		runInTerminal = true,
		console = "integratedTerminal",
	    },
	})
    end
}
