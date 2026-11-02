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

-- vim-slime ------------------------
keyset('n', '<TAB>', function() require('slime_tmux').send_line() end)
keyset('x', '<TAB>', ":<C-u>lua require('slime_tmux').send_selection()<cr>", { silent = true })
-- exit terminal with Ctrl+q
keyset('t', '<C-q>', '<C-\\><C-n>')
-- wrap R expression (TODO: see about a lua function that would handle python and R)
keyset('x', 'E', '$%')

-- fzf ------------------------------
keyset('n', '<leader>f', fzf_files)
keyset('n', '<leader>Fd', fzf_dirs)
keyset('n', '<leader>Fg', ':FzfGrepInGitFiles ')

-- oil ------------------------------
keyset("n", "<leader>e", "<cmd>Oil<cr>")

-- opencode --------------------------
keyset('n', '<leader>b', function() require('opencode_context').send() end)

-- outline --------------------------
keyset('n', '<leader>o', ':Outline<cr>')
