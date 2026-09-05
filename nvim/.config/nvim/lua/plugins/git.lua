return {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
	{ "<leader>gs", vim.cmd.Git },
	{ "<leader>gb", ":Git blame<CR>" },
    }
}
