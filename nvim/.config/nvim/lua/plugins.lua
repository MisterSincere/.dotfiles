
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

-- theming
Plug('khaveesh/vim-fish-syntax')
Plug('tikhomirov/vim-glsl')

-- tree sitter for highlighting
Plug('nvim-treesitter/nvim-treesitter')

-- let's try harpoon
Plug('theprimeagen/harpoon')

---- RUST ----
-- formatting
Plug('rust-lang/rust.vim')

---- CPP ----
-- automatic tag generation
Plug('ludovicchabant/vim-gutentags')
-- debugging
Plug('mfussenegger/nvim-dap')
Plug('theHamsta/nvim-dap-virtual-text')
-- cmake / building / execution
Plug('Shatur/neovim-cmake')
-- formatting
Plug('rhysd/vim-clang-format')
-- other
Plug('Yohannfra/Vim-Goto-Header')

-- used in status line to display git status
Plug('tpope/vim-fugitive')

-- nvim dialog tool
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-telescope/telescope-ui-select.nvim')

-- tools (among others needed by neovim cmake)
Plug('nvim-lua/plenary.nvim')

-- keybinding <leader>u
Plug('mbbill/undotree')

-- LSP Support
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim', {['do'] = ':MasonUpdate'})
Plug('williamboman/mason-lspconfig.nvim')

-- Autocompletion
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('L3MON4D3/LuaSnip')

Plug('VonHeikemen/lsp-zero.nvim', {branch = 'v2.x'})

vim.call('plug#end')
