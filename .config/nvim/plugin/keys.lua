-------------------------------------
-- "Pure" NeoVim Keys
-------------------------------------

vim.g.mapleader = ' '
local keyset = vim.keymap.set

-- tab shortcuts
keyset('n', '<leader>c', '<cmd>tabnew<cr>')
keyset('n', '<leader>x', '<cmd>quit<cr>')
keyset('n', 'K', '<cmd>tabnext<cr>')
keyset('n', 'J', '<cmd>tabprevious<cr>')

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
-- Plugin Related Keys
-------------------------------------

-- nvim-repl ------------------------
keyset('n', '<S-TAB>', '<cmd>ReplToggle<cr>')
keyset('n', '<TAB>', '<Plug>ReplSendLine')
keyset('x', '<TAB>', '<Plug>ReplSendVisual')
-- exit terminal with Ctrl+q
keyset('t', '<C-q>', '<C-\\><C-n>')
-- wrap R expression (TODO: see about a lua function that would handle python and R)
keyset('x', 'E', '$%')

-- fzf ------------------------------
keyset('n', '<leader>f', fzf_git_ls_files)
keyset('n', '<leader>F', fzf_all_files)
keyset('n', '<leader>d', fzf_all_dirs)
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
