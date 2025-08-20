
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

-- theming
Plug('khaveesh/vim-fish-syntax')
Plug('tikhomirov/vim-glsl')

-- highlight colors to how they look like
Plug('brenoprata10/nvim-highlight-colors')

-- tree sitter for highlighting
Plug('nvim-treesitter/nvim-treesitter')

-- let's try harpoon
Plug('theprimeagen/harpoon')

-- rust formatting
Plug('rust-lang/rust.vim')

-- cpp debugging
Plug('mfussenegger/nvim-dap')
Plug('theHamsta/nvim-dap-virtual-text')
-- cmake / building / execution
Plug('Shatur/neovim-cmake')
-- formatting
Plug('rhysd/vim-clang-format')

-- automatic tag generation
Plug('ludovicchabant/vim-gutentags')

-- python autopep8
Plug 'tell-k/vim-autopep8'
-- used in status line to display git status
Plug('tpope/vim-fugitive')

-- session saving
Plug('tpope/vim-obsession')

-- nvim dialog tool
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-telescope/telescope-ui-select.nvim')

-- tools (among others needed by neovim cmake)
Plug('nvim-lua/plenary.nvim')

-- keybinding <leader>u
Plug('mbbill/undotree')

-- LSP Support
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
	-- Autocompletion
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('L3MON4D3/LuaSnip')

-- remote working
Plug('nosduco/remote-sshfs.nvim')

Plug('aurum77/live-server.nvim')

vim.call('plug#end')
