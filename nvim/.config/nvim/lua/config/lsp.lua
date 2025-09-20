-- config/lsp.lua

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local util = require('lspconfig.util')

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
	vim.lsp.config[server].setup({
		capabilities = lsp_capabilities,
	})
end

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		'html',
		'phpactor',
		'vtsls',
		'tinymist',
		'lua_ls',
		'pylsp',
		'twiggy_language_server'
	},
	handlers = {
		default_setup,
	},
})
local vue_plugin = {
	name = '@vue/typescript-plugin',
	location = vim.fn.expand("$MASON/packages/vue-language-server") .. '/node_modules/@vue/language-server',
	languages = { 'vue' },
	configNamespace = 'typescript',
}
local vtsls_config = {
	root_dir = function(fname)
        return util.root_pattern('tsconfig.json', 'package.json', '.git')(fname)
            or vim.fn.getcwd()
    end,
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
	filetypes = { 'typescript', 'javascript', 'vue' }
}
local vue_ls_config = {}
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
local html_config = {
	filetypes = { "twig", "html", "templ", "jinja" }
}
local tinymist_config = {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	settings = {
		formatterMode = "typstyle",
	},
	on_attach = function(client, bufnr)
		vim.keymap.set("n", "<leader>tp", function()
			client:exec_cmd({
				title = "pin",
				command = "tinymist.pinMain",
				arguments = { vim.api.nvim_buf_get_name(0) },
			}, { bufnr = bufnr })
		end, { desc = "[T]inymist [P]in", noremap = true})
		vim.keymap.set("n", "<leader>tu", function()
			client:exec_cmd({
				title = "unpin",
				command = "tinymist.pinMain",
				arguments = { vim.v.null },
			}, { bufnr = bufnr })
		end, { desc = "[T]inymist [U]npin", noremap = true })
	end
}


vim.lsp.config('html', html_config)
vim.lsp.config('pylsp', pylsp_config)
vim.lsp.config('vtsls', vtsls_config)
vim.lsp.config('vue_ls', vue_ls_config)
vim.lsp.config('tinymist', tinymist_config)
vim.lsp.enable('vtsls')
vim.lsp.enable('vue_ls')
vim.lsp.enable('phpactor')
vim.lsp.enable('html')
vim.lsp.enable('pylsp')
vim.lsp.enable('tinymist')


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
