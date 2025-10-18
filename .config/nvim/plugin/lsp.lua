-- examples at https://github.com/neovim/nvim-lspconfig/tree/master
-- consider refactoring to use the lsp/ directory

vim.lsp.config('R', {
  cmd = { 'R', '--no-echo', '-e', 'languageserver::run()' },
  filetypes = { 'r' },
  root_markers = { 'renv.lock', '.git' },
})
vim.lsp.enable('R')

vim.lsp.config('jedi', {
  cmd = { 'jedi-language-server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', '.git' },
})
vim.lsp.enable('jedi')

vim.lsp.config('marksman', {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown', 'markdown.mdx' },
  root_markers = { '.marksman.toml', '.git' },
})
vim.lsp.enable('marksman')
