
local languages = { "lua", "vim", "vimdoc", "javascript", "html", "python", "typescript", "c" }

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function ()
	local ts = require("nvim-treesitter")
	ts.install(languages)

	vim.api.nvim_create_autocmd("FileType", {
	    group = vim.api.nvim_create_augroup("treesitter_start", {clear = true}),
	    pattern = languages,
	    callback = function(event)
		vim.treesitter.start(event.buf, vim.bo[event.buf].filetype)
	    end,
	})
    end,
}
