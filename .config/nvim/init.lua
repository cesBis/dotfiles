-- neovim configuration
-- options: https://neovim.io/doc/user/options.html
-- lua api: https://neovim.io/doc/user/lua.html
-- installed in codespace setup script by curling the appimage

require('general')
require('keys')
require('macros')
require('plugins')

-- plugin specific options can go in plugins/<name>.lua
-- see http://neovim.io/doc/user/options.html#'runtimepath'
