-- neovim configuration
-- options: https://neovim.io/doc/user/options.html
-- lua api: https://neovim.io/doc/user/lua.html
-- installed via apt

require('general')
require('keys')
require('macros')
require('plugins')

-- for clipboard, using win32yank from windows neovim installation seems to work
--   `ln -s /mnt/c/Users/Conner.Smith/programs/nvim-win64/bin/win32yank.exe /usr/local/bin/win32yank.exe`

-- plugin specific options can go in plugins/<name>.lua
-- see http://neovim.io/doc/user/options.html#'runtimepath'
