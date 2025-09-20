-- old cmake setup
---- neovim-cmake
--local Path = require('plenary.path')
--vim.g.cmake_build_dir = 'build'
--local cmake = require('cmake')
--cmake.setup({
--    cmake_executable = 'cmake',
--    save_before_build = true,
--    parameters_file = 'neovim.json',
--    build_dir = tostring(Path:new('{cwd}', 'build-{build_type}/')),
--    default_projects_path = tostring(Path:new(vim.loop.os_homedir(), 'programming')),
--    configure_args = {'-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1'},
--    build_args = {},
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
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim" },
}
