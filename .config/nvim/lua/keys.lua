vim.g.mapleader = ' '

local keyset = vim.keymap.set
local opts = {silent = true}

-- start terminal
keyset('n', '<leader>t', '<cmd>ReplToggle<cr>', opts)
-- exit terminal with Ctrl+q
keyset('t', '<C-q>', '<C-\\><C-n>')
-- send line to terminal. uses vim-sendtowindow and assumes terminal is below
keyset('n', '<leader>r', '<Plug>ReplSendLine', opts)
keyset('x', '<leader>r', '<Plug>ReplSendVisual', opts)

-- tab shortcuts
keyset('n', '<leader>c', ':tabnew<cr>', opts)
keyset('n', '<leader>x', ':tabclose<cr>', opts)
keyset('n', 'K', ':tabn<cr>', opts)
keyset('n', 'J', ':tabp<cr>', opts)

-- window shortcuts
keyset('n', '<leader>-', '<cmd>split<cr>')
keyset('n', '<leader>\\', '<cmd>vsplit<cr>')
keyset('n', '<C-h>', '<C-w>h')
keyset('n', '<C-j>', '<C-w>j')
keyset('n', '<C-k>', '<C-w>k')
keyset('n', '<C-l>', '<C-w>l')

-- clear highlight
keyset('n', '<leader>l', ':nohl<cr>:echo<cr><Esc>', opts)

-- wrap text
keyset('n','<leader>w', ':set wrap<cr>', opts)
keyset('n','<leader>uw', ':set nowrap<cr>', opts)

-- github copilot
-- from :help copilot
-- accept on `->` arrow key, like my shell autocomplete, not TAB, that's for coc
keyset('i', '<Right>', 'copilot#Accept("\\<CR>")', {expr = true,  replace_keycodes = false})
keyset('i', '<C-Right>', '<Plug>(copilot-accept-word)')
vim.g.copilot_no_tab_map = true

-- keys brought on by plugins
--
-- <leader>f is default shortcut for ranger.vim
-- gc for visual mode and motion comments, <int>gcc for commenting int lines from vim-commentary
-- cs: change surrounding | ds: delete surrounding | ys: yes new surrounding | and more! see https://github.com/tpope/vim-surround
