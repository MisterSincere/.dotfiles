return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    props = {
	ensure_installed = { "lua" },
	auto_install = true,
	highlight = {
	    enable = true,
	},
	indent = {
	    enable = true,
	},
    },
}
