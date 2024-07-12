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

-------------------------------------
-- "Pure" NeoVim Keys
-------------------------------------

vim.g.mapleader = ' '
local keyset = vim.keymap.set

-- tab shortcuts
keyset('n', '<leader>c', '<cmd>tabnew<cr>')
keyset('n', '<leader>x', '<cmd>tabclose<cr>')
keyset('n', 'K', '<cmd>tabn<cr>')
keyset('n', 'J', '<cmd>tabp<cr>')

-- window shortcuts
keyset('n', '<leader>-', '<cmd>split<cr>')
keyset('n', '<leader>\\', '<cmd>vsplit<cr>')
keyset('n', '<C-h>', '<C-w>h')
keyset('n', '<C-j>', '<C-w>j')
keyset('n', '<C-k>', '<C-w>k')
keyset('n', '<C-l>', '<C-w>l')

-- clear highlight
keyset('n', '<leader>l', '<cmd>nohl<cr><cmd>echo<cr>')

-- wrap text
keyset('n','<leader>w', '<cmd>set wrap<cr>')
keyset('n','<leader>uw', '<cmd>set nowrap<cr>')

-------------------------------------
-- Plugin Keys
-------------------------------------

-- nvim-repl ------------------------
keyset('n', '<leader>t', '<cmd>ReplToggle<cr>')
keyset('n', '<leader>r', '<Plug>ReplSendLine')
keyset('x', '<leader>r', '<Plug>ReplSendVisual')
-- exit terminal with Ctrl+q
keyset('t', '<C-q>', '<C-\\><C-n>')

-- fzf ------------------------------
keyset('n', '<leader>f', fzf_git_ls_files)
keyset('n', '<leader>F', fzf_all_files)
keyset('n', '<leader>g', ':FzfGrepInGitFiles ')

-- github copilot -------------------
-- from :help copilot
-- accept on `->` arrow key, like my shell autocomplete, not TAB, that's for coc
keyset('i', '<Right>', 'copilot#Accept("\\<CR>")', {expr = true,  replace_keycodes = false})
keyset('i', '<C-Right>', '<Plug>(copilot-accept-word)')
vim.g.copilot_no_tab_map = true

-- CoC ------------------------------
-- see `:h coc-list` and search 'coc-list-link' or 'coc-list-diagnostics'
keyset("n", "Co", ":<C-u>CocList outline<cr>", {silent = true, nowait = true})
-- see `:h coc-lsp`
-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
-- GoTo code navigation.
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})

-- keys brought on by plugins --------
--
-- gc for visual mode and motion comments, <int>gcc for commenting int lines from vim-commentary
-- cs: change surrounding | ds: delete surrounding | ys: yes new surrounding | and more! see https://github.com/tpope/vim-surround
-- TAB from plugin/coc.lua
