local group = vim.api.nvim_create_augroup("IServProjectRsync", { clear = true })
local iserv_dir = vim.fs.normalize(vim.fn.expand("~/iserv"))
local vm = "iserv-vm" -- ssh host alias

local syncing = {}
local pending = {}

local function sync_project(file)
    local project_dir = vim.fs.root(file, { ".git" })

    if not project_dir then
	return
    end

    project_dir = vim.fs.normalize(project_dir)

    -- only sync direct projects directly inside ~/iserv
    if vim.fs.normalize(vim.fn.fnamemodify(project_dir, ":h")) ~= iserv_dir then
	return
    end

    if syncing[project_dir] then
	pending[project_dir] = true
	return
    end

    local project_name = vim.fn.fnamemodify(project_dir, ":t")
    syncing[project_dir] = true

    vim.system({
	"rsync",
	"-az",
	"--exclude=.idea/",
	"--exclude=app/node_modules",
	project_dir .. "/",
	vm .. ":/root/git/" .. project_name .. "/",
    }, {
	text = true,
    }, function(result)
	syncing[project_dir] = false

	vim.schedule(function()
	    if result.code ~= 0 then
		vim.notify("rsync failed:\n" .. result.stderr, vim.log.levels.ERROR)
	    end
	end)

	if pending[project_dir] then
	    pending[project_dir] = false
	    sync_project()
	end
    end)
end

vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = "*",
    callback = function(args)
	sync_project(args.file)
    end,
})

vim.api.nvim_create_user_command("IServSync", function()
    sync_project(vim.api.nvim_buf_get_name(0))
end, {})
