vim.g.mapleader = ' '

local keyset = vim.keymap.set
local opts = {silent = true}

-- start terminal
keyset('n', '<leader>t', '<cmd>split<cr><C-w>h<cmd>terminal<cr>i', opts)
-- exit terminal with Ctrl+q
keyset('t', '<C-q>', '<C-\\><C-n>')
-- send line to terminal. uses vim-sendtowindow and assumes terminal is below
vim.g.sendtowindow_use_defaults = 0
keyset('n', '<leader>r', '0<Plug>SendDown$<C-W>jG<C-W>k', opts)
keyset('x', '<leader>r', '<Plug>SendDownV<C-W>jG<C-W>k', opts)

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

-- fzf from apt
keyset('n', '<leader>f', ':FZF<cr>', opts)

-- github copilot
-- from :help copilot
-- accept on `->` arrow key, like my shell autocomplete
vim.keymap.set('i', '<Right>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

-- keys brought on by plugins
--
-- gc for visual mode and motion comments, <int>gcc for commenting int lines from vim-commentary
-- cs: change surrounding | ds: delete surrounding | ys: yes new surrounding | and more! see https://github.com/tpope/vim-surround
