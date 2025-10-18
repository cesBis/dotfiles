-------------------------------------
-- "Pure" NeoVim Keys
-------------------------------------

vim.g.mapleader = ' '
local keyset = vim.keymap.set

-- tab shortcuts
keyset('n', '<leader>c', '<cmd>tabnew<cr>')
keyset('n', '<leader>x', '<cmd>tabclose<cr>')
keyset('n', '<M-k>', '<cmd>tabnext<cr>')
keyset('n', '<M-j>', '<cmd>tabprevious<cr>')

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
keyset('n', '<TAB>', '<Plug>(ReplSendLine)')
keyset('x', '<TAB>', '<Plug>(ReplSendVisual)')
-- exit terminal with Ctrl+q
keyset('t', '<C-q>', '<C-\\><C-n>')
-- wrap R expression (TODO: see about a lua function that would handle python and R)
keyset('x', 'E', '$%')

-- fzf ------------------------------
keyset('n', '<leader>f', fzf_files)
keyset('n', '<leader>Fd', fzf_dirs)
keyset('n', '<leader>Fg', ':FzfGrepInGitFiles ')

-- blink.nvim -----------------------
require('blink.cmp').setup({
  keymap = {
    preset = 'none',
    ['<TAB>'] = {'select_next', 'fallback'},
    ['<S-TAB>'] = {'select_prev', 'fallback'},
  },
  completion = {list = {selection = {preselect = false, auto_insert = true}}},
})

-- oil ------------------------------
keyset("n", "<leader>e", "<cmd>Oil<cr>")

-- chatbot --------------------------
keyset('n', '<leader>b', ':GpChatNew tabnew<cr>')
keyset('x', '<leader>bp', ':GpChatPaste<cr>')
keyset('n', '<leader>Fb', ':GpChatFinder<cr>')

-- keys brought on by plugins --------
--
-- gc for visual mode and motion comments, <int>gcc for commenting int lines, see :help commentary.txt
-- cs: change surrounding | ds: delete surrounding | ys: yes new surrounding , see :help surround
