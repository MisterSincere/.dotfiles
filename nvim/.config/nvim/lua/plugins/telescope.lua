local function gutentags_init()
    vim.g.gutentags_exclude_project_root = {'home/kaffeekind/programming/mtstudio/projects/*'}
    vim.g.gutentags_cache_dir = os.getenv('HOME') .. '/.cache/gutentags/'
    vim.g.gutentags_ctags_exclude = {
	'.idea/*', '*.git', '*.svg', '*.hg', '*/tests/*', 'build',
	'dist', 'bin', 'node_modules', 'cache', 'compiled', 'docs',
	'example', 'vendor', '*.md', '*-lock.json', '*.min.*', '*.bak',
	'*.pyc', '*.class', '*.tmp', '*.cache', 'tags*', '*.mp3', '*.ogg',
	'*.flac', '*.swp', '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
	'*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
	'*.pdf', '*.json',
    }
end


return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { 
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	{
	    "ludovicchabant/vim-gutentags",
	    init = gutentags_init,
	}
    },
    opts = {
	defaults = {
	    mappings = {
		i = {
		    ["<F1>"] = require("telescope.actions").close,
		    ["<ESC>"] = require("telescope.actions").close,
		},
	    },
	},
    },
    config = function(lazyPlugin, opts) 
	local tel = require("telescope")
	tel.setup(opts)
	tel.load_extension("ui-select")
    end,
    keys = {
	{ "<leader><leader>", require("telescope.builtin").tags },
	{ "<leader>pv", require("utils.file_browsing").project_view },
	{ "<leader>ps", require("utils.file_browsing").project_search },
    },
}
