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

-- https://github.com/folke/lazy.nvim#-plugin-spec
require('lazy-init')
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

-------------------------------------
-- commands (some plugin dependence)
-------------------------------------

require('keys')

-------------------------------------
-- miscellaneous
-------------------------------------

vim.cmd.set('splitbelow splitright number relativenumber nowrap mouse=a encoding=utf8 clipboard=unnamedplus,unnamed ignorecase smartcase')
vim.cmd.colorscheme('mine')

-- tab characters and spaces: first and last line set default, middle lines set exceptions
vim.cmd [[
  set expandtab tabstop=2 shiftwidth=2
  autocmd BufEnter *.py set tabstop=4|set shiftwidth=4
  autocmd BufLeave * set tabstop=2|set shiftwidth=2
]]
