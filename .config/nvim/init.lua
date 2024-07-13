---------------------------------------------------------------------------------------------------------
-- https://neovim.io/doc/user/options.html
-- https://neovim.io/doc/user/lua.html
-- :h runtimepath
-- installed via apt
--
-- for clipboard, using win32yank from windows neovim installation seems to work
--   `ln -s /mnt/c/Users/Conner.Smith/programs/nvim-win64/bin/win32yank.exe /usr/local/bin/win32yank.exe`
---------------------------------------------------------------------------------------------------------

-------------------------------------
-- lazy.nvim
-------------------------------------

-- https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system("git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable " .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

-- https://github.com/folke/lazy.nvim#-plugin-spec
require("lazy").setup({
  {"pappasam/nvim-repl"},
  {'ap/vim-css-color'},
  {'windwp/nvim-autopairs', config = function() require("nvim-autopairs").setup() end},
  {'nvim-lualine/lualine.nvim', dependencies = {'kyazdani42/nvim-web-devicons'}},
  {'tpope/vim-fugitive'},
  {'tpope/vim-commentary'},
  {'tpope/vim-surround'},
  {'github/copilot.vim'},
  {'neoclide/coc.nvim', branch = 'release'}
})
