local pylsp_config = {
	plugins = {
		pycodestyle = {
			-- E265: block comment should start with '# '
			-- E231: missing whitespace after ','
			-- E501: line too long
			ignore = {'E265', 'E231', 'E501'},
		}
	}
}

local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = {buffer = event.buf}

		vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
		vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
		vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
		vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
		vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
		vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
		vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		vim.keymap.set('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
		vim.keymap.set('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	end
})

local default_setup = function(server)
	lspconfig[server].setup({
		capabilities = lsp_capabilities,
	})
end

local mason_registry = require('mason-registry')
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		'html',
		'phpactor',
		'ts_ls',
		'lua_ls',
		'volar',
		'twiggy_language_server'
	},
	handlers = {
		default_setup,
		pylsp = function()
			lspconfig.pylsp.setup({
				settings = {
					pylsp = pylsp_config
				}
			})
		end,
	},
})
lspconfig.ts_ls.setup({
	init_options = {
		plugins = {
			{
				name = '@vue/typescript-plugin',
				location = vim.fn.expand("$MASON/packages/vue-language-server") .. '/node_modules/@vue/language-server',
				languages = { 'javascript', 'typescript', 'vue' }
			},
		},
	},
	filetypes = { 'vue' }
})
lspconfig.html.setup({
	filetypes = { "twig", "html", "templ" }
})
lspconfig.volar.setup({})

local cmp = require('cmp')
cmp.setup({
	sources = {
		{name = 'nvim_lsp'},
	},
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({select = false}),
		['<C-Space>'] = cmp.mapping.complete(),
	}),
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
})

vim.diagnostic.config({
	virtual_text = false,
	float = {
		focusable = false,
		style =  "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = false,
});
