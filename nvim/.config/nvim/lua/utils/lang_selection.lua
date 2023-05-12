-- utils/lang_sections.lua

local M = {}

function M.is_c()
	ft = vim.bo.filetype
	return ft == "cpp"
		or ft == "c" 
		or ft == "mtrg"
		or ft == "mtprj"
		or ft == "cmake"
end

function M.is_rust()
	ft = vim.bo.filetype
	return ft == "rust"
		or ft == "toml"
end

function M.is_python()
	ft = vim.bo.filetype
	return ft == "python"
end


return M
