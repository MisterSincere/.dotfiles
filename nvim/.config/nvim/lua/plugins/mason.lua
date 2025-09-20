return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
		ensure_installed = {
			"html",
			"phpactor",
			"vtsls",
			"tinymist",
			"lua_ls",
			"pylsp",
			"twiggy_language_server",
		},
		automatic_enable = false,
	},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
