-- config/lsp.lua

local map = require("utils.keymap")
local uv = vim.uv or vim.loop

local function path_join(...)
    return table.concat({ ... }, "/")
end

local function is_file(p)
    local st = uv.fs_stat(p)
    return st and st.type == "file"
end

local function is_dir(p)
    local st = uv.fs_stat(p)
    return st and st.type == "directory"
end

local function find_project_root(bufnr)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    if fname == "" then return vim.fn.getcwd() end
    local dir = vim.fs.dirname(fname)
    local root = vim.fs.find(
	{ ".git", "SConstruct", "pyproject.toml", "requirements.txt", "setup.py" },
	{ upward = true, path = dir }
    )[1]
    return root and vim.fs.dirname(root) or dir
end

-- tries to detect a venv by checking 3 different conditions in the following order
-- 1) VIRTUAL_ENV variable being set
-- 2) check if .venv or venv exist in repo root
local function detect_venv_python(root)
    local venv = vim.env.VIRTUAL_ENV
    if venv and venv ~= "" then
	local py = path_join(venv, "bin", "python")
	if is_file(py) then return py end
    end

    local candidates = {
	path_join(root, ".venv", "bin", "python"),
	path_join(root, "venv", "bin", "python"),
    }
    for _, py in ipairs(candidates) do
	if is_file(py) then return py end
    end

    return nil
end

-- gem5 detection and adding extra paths if detected
local function gem5_extra_paths(root)
    -- gem5 repo has src/python and src/sim among others, we use src/python as our key
    local src_python = path_join(root, "src", "python")
    if not is_dir(src_python) then
	return nil
    end

    -- if built gem5 generated build/<ISA>/python
    -- adding any build/*/python that exists so they don't need to be hardcoded
    local extra = { src_python, path_join(root, "src", "sim") }
    local build_dir = path_join(root, "build")
    if is_dir(build_dir) then
	local matches = vim.fs.find("python", { path = build_dir, type = "directory", limit = math.huge })
	for _, p in ipairs(matches) do
	    if p:match("/build/[^/]+/python$") then
		table.insert(extra, p)
	    end
	end
    end

    return extra
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client or client.name ~= "pylsp" then return end
	local root = find_project_root(ev.buf)
	local py = detect_venv_python(root)
	if py then
	    client.config.settings = client.config.settings or {}
	    client.config.settings.pylsp = client.config.settings.pylsp or {}
	    client.config.settings.pylsp.plugins = client.config.settings.pylsp.plugins or {}
	    client.config.settings.pylsp.plugins.jedi = client.config.settings.pylsp.plugins.jedi or {}
	    client.config.settings.pylsp.plugins.jedi.environment = py
	end

	local extra_paths = gem5_extra_paths(root)
	if extra_paths then
	    client.config.settings = client.config.settings or {}
	    client.config.settings.pylsp = client.config.settings.pylsp or {}
	    client.config.settings.pylsp.plugins = client.config.settings.pylsp.plugins or {}
	    client.config.settings.pylsp.plugins.jedi = client.config.settings.pylsp.plugins.jedi or {}
	    client.config.settings.pylsp.plugins.jedi.extra_paths = extra_paths
	end

	client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
	local opts = {buffer = event.buf}
	map.n('gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--	map.n('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	map.n('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--	map.n('gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--	map.n('gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    end
})

local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vim.fn.expand("$MASON/packages/vue-language-server") .. '/node_modules/@vue/language-server',
    languages = { 'vue' },
    configNamespace = 'typescript',
}

local default_capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('*', { capabilities = default_capabilities })
vim.lsp.config('stylelint', {})

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
    capabilities = default_capabilities,
    settings = {
	pylsp = {
	    rope = {
		ropeFolder = ".ropeproject",
	    },
	    plugins = {
		pycodestyle = {
		    -- E265: block comment should start with '# '
		    -- E231: missing whitespace after ','
		    -- E501: line too long
		    ignore = {'E265', 'E231', 'E501'},
		},
		rope_autoimport = {
		    enabled = true,
		},
	    }
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

--vim.lsp.config("rust_analyzer", {
--    settings ={
--	["rust-analyzer"] = {
--	    diagnostics = {
--		enable = false,
--	    },
--	},
--    },
--})
-- since using rustaceanvim
vim.g.rustaceanvim = {
    tools = {},
    dap = {},
    server = {
	default_settings = {
	    ["rust-analyzer"] = {
		diagnostics = {
		    enable = false,
		},
	    },
	},
    },
}

vim.lsp.config("html", {
    filetypes = { "twig", "html", "templ", "jinja" }
})

vim.lsp.enable({ "clangd", "ts_ls", "vue_ls", "phpactor", "html", "pylsp", "tinymist", "lua_ls", "twiggy_language_server", "stylelint" })

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
