-- installed via apt
-- options: https://neovim.io/doc/user/options.html
-- lua api: https://neovim.io/doc/user/lua.html
-- :h runtimepath
--
-- for clipboard, using win32yank from windows neovim installation seems to work
--   `ln -s /mnt/c/Users/Conner.Smith/programs/nvim-win64/bin/win32yank.exe /usr/local/bin/win32yank.exe`

require('plugins')
require('macros')
require('keys')

-- tab characters and spaces: first and last line set default, middle lines set exceptions
vim.cmd [[
  set expandtab tabstop=2 shiftwidth=2
  autocmd BufEnter *.py set tabstop=4|set shiftwidth=4
  autocmd BufLeave * set tabstop=2|set shiftwidth=2
]]

vim.cmd.colorscheme('mine')
vim.cmd.set('splitbelow splitright number relativenumber nowrap mouse=a encoding=utf8 clipboard=unnamedplus,unnamed ignorecase smartcase')
