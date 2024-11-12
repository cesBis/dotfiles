---------------------------------------------------------------------------------------------------------
-- https://neovim.io/doc/user/options.html
-- https://neovim.io/doc/user/lua.html
-- installed appimage via curl in setup
--
-- see ./plugin/files, which are automatically sourced after this
-- see :h runtimepath and :h startup
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
  {'junegunn/fzf'},
  {'windwp/nvim-autopairs', config = function() require("nvim-autopairs").setup() end},
  {'nvim-lualine/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons'}},
  {'tpope/vim-fugitive'},
  {'tpope/vim-rhubarb', dependencies = {'tpope/vim-fugitive'}},
  {'tpope/vim-commentary'},
  {'tpope/vim-surround'},
  {'github/copilot.vim'},
  {'robitx/gp.nvim'},
  {'neoclide/coc.nvim', branch = 'release'},
  {'uga-rosa/ccc.nvim', config = function() require("ccc").setup({highlighter = { auto_enable = true }}) end},
  {'stevearc/oil.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, config = function() require("oil").setup() end},
})
