
local setup  = function()
	local Plug = vim.fn['plug#']
  	vim.call('plug#begin', '~/.config/nvim/plugged')

	-- theming
  	Plug 'khaveesh/vim-fish-syntax'
  	Plug 'tikhomirov/vim-glsl'

	---- RUST ----
	-- syntax checking
	--Plug 'dense-analysis/ale'
	-- formatting
	Plug 'rust-lang/rust.vim'

	---- CPP ----
	-- highlighting
	Plug 'bfrg/vim-cpp-modern'
	-- automatic tag generation
	Plug 'ludovicchabant/vim-gutentags'
	-- debugging
  	Plug 'mfussenegger/nvim-dap'
  	Plug 'nvim-treesitter/nvim-treesitter'
  	Plug 'theHamsta/nvim-dap-virtual-text'
	-- cmake / building / execution
  	Plug 'Shatur/neovim-cmake'
	-- formatting
	Plug 'rhysd/vim-clang-format'
	-- other
  	Plug 'Yohannfra/Vim-Goto-Header'

	-- python autopep8
	Plug 'tell-k/vim-autopep8'

	-- used in status line to display git status
  	Plug 'tpope/vim-fugitive'
	
	-- a bufferline and its icons
  	Plug 'kyazdani42/nvim-web-devicons'
  	Plug 'noib3/nvim-cokeline'
  	
	-- nvim dialog tool
  	Plug 'nvim-telescope/telescope.nvim'
  	Plug 'nvim-telescope/telescope-ui-select.nvim'

	-- tools (among others needed by neovim cmake)
  	Plug 'nvim-lua/plenary.nvim'

	-- format cpp file according to .clang-format via <leader>f

	-- keybinding <leader>u
	Plug 'mbbill/undotree'

	--Plug 'lyuts/vim-rtags'
  	--Plug 'vim-utils/vim-man'
  	
  	vim.call('plug#end')
end

return {
  setup = setup
}
