-- plugins

-- https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then 
  vim.fn.system("git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable" .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

-- https://github.com/folke/lazy.nvim#-plugin-spec
require("lazy").setup({
  {"pappasam/nvim-repl"},
  {'junegunn/fzf'},
  {'ap/vim-css-color'},
  {'windwp/nvim-autopairs', config = function() require("nvim-autopairs").setup() end},
  {'nvim-lualine/lualine.nvim', dependencies = {'kyazdani42/nvim-web-devicons'}},
  {'tpope/vim-fugitive'},
  {'tpope/vim-commentary'},
  {'tpope/vim-surround'},
  {'github/copilot.vim'},
  {'neoclide/coc.nvim', branch = 'release'}
})
-- https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#install-extensions
vim.g.coc_global_extensions = {'coc-json', 'coc-r-lsp', 'coc-jedi'}
-- see more language servers at https://github.com/neoclide/coc.nvim/wiki/Language-servers
