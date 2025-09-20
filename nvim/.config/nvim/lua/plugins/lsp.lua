return {
    {
	"mason-org/mason-lspconfig.nvim",
	opts = {
	    ensure_installed = {
		"html",
		"phpactor",
		"ts_ls",
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
	    "hrsh7th/cmp-nvim-lsp",
	},
    },
    {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
	    library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	    },
	},
    },
    {
	"hrsh7th/nvim-cmp",
	config = function()
	    local cmp = require("cmp")
	    cmp.setup({
		sources = {
		    { name = "lazydev", group_index = 0 },
		    { name = "nvim_lsp" },
		},
		mapping = cmp.mapping.preset.insert({
		    ["<CR>"] = cmp.mapping.confirm({ select = false }),
		    ["<C-Space>"] = cmp.mapping.complete(),
		}),
		snippet = {
		    expand = function(args)
			require("luasnip").lsp_expand(args.body)
		    end
		},
	    })
	end,
	dependencies = {
	    "L3MON4D3/LuaSnip"
	}
    },
}
