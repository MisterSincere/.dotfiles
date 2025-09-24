-- config/lsp.lua

local map = require("utils.keymap")

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
	local opts = {buffer = event.buf}
--	map.n('K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	map.n('gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--	map.n('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--	map.n('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--	map.n('gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--	map.n('gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--	map.n('gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--	map.n('[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--	map.n(']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    end
})

local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vim.fn.expand("$MASON/packages/vue-language-server") .. '/node_modules/@vue/language-server',
    languages = { 'vue' },
    configNamespace = 'typescript',
}

vim.lsp.config('*', { capabilities = require('cmp_nvim_lsp').default_capabilities() })

vim.lsp.config("ts_ls", {
    init_options = {
	plugins = {
	    vue_plugin,
	},
    },
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
})

vim.lsp.config("vue_ls", {
    on_init = function(client)
	client.handlers['tsserver/request'] = function(_, result, context)
	    local ts_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })
	    local vtsls_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
	    local clients = {}

	    vim.list_extend(clients, ts_clients)
	    vim.list_extend(clients, vtsls_clients)

	    if #clients == 0 then
		vim.notify('Could not find `vtsls` or `ts_ls` lsp client, `vue_ls` would not work without it.', vim.log.levels.ERROR)
		return
	    end
	    local ts_client = clients[1]

	    local param = unpack(result)
	    local id, command, payload = unpack(param)
	    ts_client:exec_cmd({
		title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
		command = 'typescript.tsserverRequest',
		arguments = {
		    command,
		    payload,
		},
	    }, { bufnr = context.bufnr }, function(_, r)
		local response = r and r.body
		-- TODO: handle error or response nil here, e.g. logging
		-- NOTE: Do NOT return if there's an error or no response, just return nil back to the vue_ls to prevent memory leak
		local response_data = { { id, response } }

		---@diagnostic disable-next-line: param-type-mismatch
		client:notify('tsserver/response', response_data)
	    end)
	end
    end,
})

vim.lsp.config("pylsp", {
    plugins = {
	pycodestyle = {
	    -- E265: block comment should start with '# '
	    -- E231: missing whitespace after ','
	    -- E501: line too long
	    ignore = {'E265', 'E231', 'E501'},
	}
    }
})

vim.lsp.config("tinymist", {
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
})

vim.lsp.config("html", {
    filetypes = { "twig", "html", "templ", "jinja" }
})

vim.lsp.enable({ "ts_ls", "vue_ls", "phpactor", "html", "pylsp", "tinymist", "lua_ls", "twiggy_language_server", "stylelint" })

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
