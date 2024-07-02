------------------------------------
-- "Pure" NeoVim Keys
-------------------------------------

vim.g.mapleader = ' '
local keyset = vim.keymap.set

-- tab shortcuts
keyset('n', '<leader>c', ':tabnew<cr>', {silent = true})
keyset('n', '<leader>x', ':tabclose<cr>', {silent = true})
keyset('n', 'K', ':tabn<cr>', {silent = true})
keyset('n', 'J', ':tabp<cr>', {silent = true})

-- window shortcuts
keyset('n', '<leader>-', '<cmd>split<cr>')
keyset('n', '<leader>\\', '<cmd>vsplit<cr>')
keyset('n', '<C-h>', '<C-w>h')
keyset('n', '<C-j>', '<C-w>j')
keyset('n', '<C-k>', '<C-w>k')
keyset('n', '<C-l>', '<C-w>l')

-- clear highlight
keyset('n', '<leader>l', ':nohl<cr>:echo<cr><Esc>', {silent = true})

-- wrap text
keyset('n','<leader>w', ':set wrap<cr>', {silent = true})
keyset('n','<leader>uw', ':set nowrap<cr>', {silent = true})

-------------------------------------
-- Plugin Keys
-------------------------------------

-- nvim-repl ------------------------
keyset('n', '<leader>t', '<cmd>ReplToggle<cr>', {silent = true})
keyset('n', '<leader>r', '<Plug>ReplSendLine', {silent = true})
keyset('x', '<leader>r', '<Plug>ReplSendVisual', {silent = true})
-- exit terminal with Ctrl+q
keyset('t', '<C-q>', '<C-\\><C-n>')

-- fzf ------------------------------
keyset('n', '<leader>f', ":lua fzf_on('git ls-files')<cr>", {silent = true})
keyset('n', '<leader>F', ":lua fzf_on('find . -type f | cut -c 3- | sort')<cr>", {silent = true})

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
-- TAB from ../plugin/coc.lua
