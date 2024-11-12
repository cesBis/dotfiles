-- https://github.com/neoclide/coc.nvim#example-lua-configuration
-- https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#install-extensions
-- see more language servers at https://github.com/neoclide/coc.nvim/wiki/Language-servers
vim.g.coc_global_extensions = {'coc-json', 'coc-r-lsp', 'coc-jedi', '@yaegassy/coc-marksman'}

-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false
-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
vim.opt.updatetime = 300
-- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
vim.opt.signcolumn = "yes"

-- Auto complete helper function
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
