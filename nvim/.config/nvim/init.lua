-- init.lua
require('plugins')
require('plugin-config')
require('coloring')
require('options')
require('keybindings')

vim.cmd('source ~/.config/nvim/vim/statusline.vim')
vim.cmd('source ~/.config/nvim/vim/autocommands.vim')
