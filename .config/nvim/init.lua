-- neovim configuration
-- example: https://github.com/numToStr/dotfiles/tree/master/neovim/.config/nvim
-- options: https://neovim.io/doc/user/options.html
-- lua api: https://neovim.io/doc/user/lua.html
-- installed via `sudo curl -Lo /usr/local/bin/nvim https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage && sudo chmod 755 /usr/local/bin/nvim`

require('general')
require('keys')
require('macros')
require('plugins')

-- plugin specific options can go in plugins/<name>.lua
-- see http://neovim.io/doc/user/options.html#'runtimepath'
