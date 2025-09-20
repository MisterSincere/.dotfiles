return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function ()
	local configs = require("nvim-treesitter.configs")
	configs.setup({
	    modules = {},
	    ensure_installed = {
		"c", "lua", "vim", "vimdoc", "javascript", "html", "python", "typescript",
	    },
	    sync_install = false,
	    auto_install = true,
	    highlight = {
		enable = true,
	    },
	    ignore_install = {},
	})
    end,
}
