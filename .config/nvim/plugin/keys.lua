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
keyset('n', '<leader>fd', fzf_dirs)
keyset('n', '<leader>fg', ':FzfGrepInGitFiles ')

-- github copilot -------------------
keyset('i', '<Right>', 'copilot#Accept("\\<CR>")', {expr = true,  replace_keycodes = false})
keyset('i', '<C-Right>', '<Plug>(copilot-accept-word)')

-- CoC ------------------------------
keyset("n", "<leader>o", "<cmd>CocOutline<cr>")
-- see `:h coc-lsp`
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
-- GoTo code navigation.
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
-- Tab complete
keyset("i", "<TAB>", [[coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()]], {silent = true, noremap = true, expr = true, replace_keycodes = false})
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], {silent = true, noremap = true, expr = true, replace_keycodes = false})

-- oil ------------------------------
keyset("n", "-", "<cmd>Oil<cr>")

-- chatbot --------------------------
keyset('n', '<leader>b', ':GpChatNew<cr>')
keyset('n', '<leader>bc', ':GpChatNew tabnew<cr>')
keyset('n', '<leader>bf', ':GpChatFinder<cr>')

-- keys brought on by plugins --------
--
-- gc for visual mode and motion comments, <int>gcc for commenting int lines, see :help commentary.txt
-- cs: change surrounding | ds: delete surrounding | ys: yes new surrounding , see :help surround
