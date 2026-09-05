return {
    -- file browsing
    {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	lazy = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
	    local harpoon = require("harpoon")
	    harpoon:setup()
	    for i=1,9 do
		vim.keymap.set(
		    "n", ("<leader>%s"):format(i),
		    function()
			harpoon:list():select(i)
		    end
		)
	    end
	end,
	keys = {
	    {
		"<leader>aa",
		function()
		    require("harpoon"):list():add()
		end
	    },
	    {
		"<leader>ah",
		function ()
		    require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
		end
	    },
	},
    },
    {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
	    sort = {
		sorter = "case_sensitive",
	    },
	    view = {
		width = 30,
	    },
	    renderer = {
		group_empty = true,
	    },
	    filters = {
		dotfiles = true,
	    },
	},
	keys = {
	    { "<leader>e", ":NvimTreeToggle<CR>", silent = true }
	}
    },
    {
	"danymat/neogen",
	config = true,
    },

    -- nvim session recovery
    { "tpope/vim-obsession" },

    -- formatting
    { "rhysd/vim-clang-format" },
    { "MisterSincere/rust.vim" },
    { "tell-k/vim-autopep8" },

    -- syntax highlighting
    { "khaveesh/vim-fish-syntax" },
    { "tikhomirov/vim-glsl" },
    {
	"brenoprata10/nvim-highlight-colors",
	config = true,
    },

    -- undotree (barely use it, investigate)
    {
	"mbbill/undotree",
	keys = {
	    { "<C-u>", vim.cmd.UndotreeToggle }
	}
    },

    -- markdown
    {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
    },

    {
	"ron-rs/ron.vim",
    },

    {
	"nvim-mini/mini.pairs",
	version = false,
	config = function()
	    require("mini.pairs").setup()
	end,
    },
}

--Plug('folke/lazydev.nvim')
--
---- session saving
--Plug('tpope/vim-obsession')
--
-- theming
--Plug('khaveesh/vim-fish-syntax')
--Plug('tikhomirov/vim-glsl')
--
---- keybinding <leader>u
--Plug('mbbill/undotree')
--
---- Autocompletion
--Plug('hrsh7th/nvim-cmp')
--Plug('hrsh7th/cmp-nvim-lsp')
--Plug('L3MON4D3/LuaSnip')
--
---- remote working
--Plug('nosduco/remote-sshfs.nvim')
--Plug('aurum77/live-server.nvim')
--
--vim.call('plug#end')
