-- plugins

-- https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- https://github.com/folke/lazy.nvim#-plugin-spec
require("lazy").setup({
    {'karoliskoncevicius/vim-sendtowindow'},
    {'ap/vim-css-color'},
    {'windwp/nvim-autopairs', config = function() require("nvim-autopairs").setup() end},
    {'nvim-lualine/lualine.nvim', dependencies = {'kyazdani42/nvim-web-devicons'}}
})
