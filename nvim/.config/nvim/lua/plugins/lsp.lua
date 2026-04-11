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
	build = "make install_jsregexp",
	version = "v2.*",
	config = function()
	    local cmp = require("cmp")
	    cmp.setup({
		snippet = {
		    expand = function(args)
			require("luasnip").lsp_expand(args.body)
		    end
		},
		window = {
		    completion = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert(
		    {
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		    }
		),
		sources = cmp.config.sources(
		    {
			{ name = "nvim_lsp" },
			--{ name = "lazydev", group_index = 0 },
		    }, {
			{ name = "buffer" },
		    }
		),
	    })
	end,
	dependencies = {
	    "L3MON4D3/LuaSnip"
	}
    },
}
