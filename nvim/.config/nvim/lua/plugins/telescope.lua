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
    --branch = "master",
    -- this was the master commit that finally worked... dunno what's going on with them
    -- having 0.1.8 an 16 months old state
    commit = "b4da76be54691e854d3e0e02c36b0245f945c2c7",
    lazy = false,
    dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	{
	    "ludovicchabant/vim-gutentags",
	    init = gutentags_init,
	}
    },
    config = function(_, _)
	local tel = require("telescope")
	local map = require("utils.keymap")
	tel.setup({
	    defaults = {
		mappings = {
		    i = {
			["<F1>"] = require("telescope.actions").close,
			["<ESC>"] = require("telescope.actions").close,
		    },
		},
	    },
	})
	tel.load_extension("ui-select")
	map.n("<leader><leader>", require("telescope.builtin").tags)
	map.n("<leader>pv", require("utils.file_browsing").project_view)
	map.n("<leader>ps", function()
	    require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
	end)
    end,
}
