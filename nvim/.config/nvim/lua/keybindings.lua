local function map(mode, combo, mapping, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, combo, mapping, options)
end

local function imap(combo, mapping, opts)
  map('i', combo, mapping, opts)
end

local function nmap(combo, mapping, opts)
  map('n', combo, mapping, opts)
end

local setup = function()
  -- key to enter command mode
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "
  
  imap('jj', '<ESC>')
  
  nmap('<F12', ':e ~/.config/nvim/init.lua<CR>')
  --nmap <F5> :source ~/.vim/vimrc<CR>
  
  nmap('<leader>gh', ':diffget //3<CR>')
  nmap('<leader>gu', ':diffget //2<CR>')
  nmap('<leader>gs', ':G<CR>')
  
  -- keypress do disable search result highlighting
  nmap('<leader>n', ':nohlsearch<CR>')
  
  -- win commands with leader
  nmap('<leader>h', ':wincmd h<CR>')
  nmap('<leader>j', ':wincmd j<CR>')
  nmap('<leader>k', ':wincmd k<CR>')
  nmap('<leader>l', ':wincmd l<CR>')
  
  -- redo command
  nmap('<leader>r', ':redo<CR>')

  -- buffer commands
  nmap('gn', ':bn<CR>')
  nmap('gp', ':bp<CR>')
  
  -- save and close commands with leader
  nmap('<leader>s', ':w<CR>')
  nmap('<leader>q', ':q<CR>')
  
  nmap('<leader>u', ':UndotreeShow<CR>')
  nmap('<leader>ps', ':Rg<space>')
  
  -- resizing with leader
  nmap('<leader>=', ':vertical resize +5<CR>', {silent=true})
  nmap('<leader>-', ':vertical resize -5<CR>', {silent=true})
  
  -- ycm plugin keybinds
  nmap('<leader>d', ':lua require\'utils.sensitive_funcs\'.goto_definition()<CR>', {silent=true})
  nmap('<leader>gf', ':YcmCompleter FixIt<CR>', {silent=true})
  nmap('<leader>gr', ':YcmCompleter RefactorRename<space>')
  nmap('<leader>gt', ':YcmCompleter GetType<CR>')
  nmap('<leader>gu', ':YcmCompleter GoToReferences<CR>')
  
  -- tpopes fugitive
  nmap('<leader>b', ':Git blame<CR>')
  
  -- show nvim configs / reload configs
  nmap('<F1>', '<cmd>:lua require("utils.reload").reload()<CR>', {silent=true,noremap=false})

  -- telescope / project view
  nmap('<leader>v', '<cmd>:lua require("utils.project_view").view()<CR>', {silent=true})
  -- telescope / tags view
  nmap('<leader><leader>', '<cmd>:lua require("telescope.builtin").tags{}<CR>', {silent=true})
  
  -- cokeline
  nmap('<Tab>',				'<Plug>(cokeline-focus-next)', {silent = true, noremap = false})
  nmap('<S-Tab>',   		'<Plug>(cokeline-focus-prev)', {silent = true, noremap = false})
  nmap('<leader>c', 		'<Plug>(cokeline-pick-close)', {silent = true, noremap = false})
  for i = 1,9 do
	nmap(('<leader>%s'):format(i),	('<Plug>(cokeline-focus-%s)'):format(i),  {silent = true})
  end

  -- gotoheader
  nmap('<F12>', ':GotoHeader<CR>')
  imap('<F12>', '<ESC>:GotoHeader<CR>')
  nmap('<leader>gh', ':GotoHeaderSwitch<CR>')

  -- cmake building
  nmap('<C-t>', ':CMake select_target<CR>')
  nmap('<C-d>', ':CMake select_build_type<CR>')
  nmap('<C-c>', ':CMake configure<CR>')
  nmap('<C-b>', ':lua require \'utils.sensitive_funcs\'.build_all()<CR>')
  nmap('<C-Shift-b>', ':lua require \'utils.sensitive_funcs\'.build()<CR>')
  nmap('<C-a>', ':lua require \'utils.sensitive_funcs\'.set_run_args()<CR>')
  nmap('<leader><F5>', ':lua require\'utils.sensitive_funcs\'.run_debug()<CR>', {silent=false})
  nmap('<F5>', ':lua require\'utils.sensitive_funcs\'.run()<CR>')

  -- debugging
  nmap('<F9>', ':lua require\'utils.sensitive_funcs\'.toggle_breakpoint()<CR>')
  nmap('<leader><F9>', ':lua require\'utils.sensitive_funcs\'.conditional_breakpoint()<CR>')
  nmap('<F6>', ':lua require\'utils.sensitive_funcs\'.step_into()<CR>')
  nmap('<F7>', ':lua require\'utils.sensitive_funcs\'.step_over()<CR>')
  nmap('<F8>', ':lua require\'utils.sensitive_funcs\'.continue()<CR>')
  nmap('<F10>', ':lua require\'utils.sensitive_funcs\'.show_dbg_value()<CR>', {silent=false})
  nmap('<F11>', ':lua require\'utils.sensitive_funcs\'.close_dbg_value()<CR>', {silent=false})

  -- format (now language sensitive)
  nmap('<leader>f', ':lua require\'utils.sensitive_funcs\'.format()<CR>', {silent = true})
end

return {
  setup = setup
}
