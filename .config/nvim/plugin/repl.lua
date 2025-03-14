-- https://github.com/pappasam/nvim-repl
vim.g.repl_split = "bottom"
vim.g.repl_filetype_commands = {
  python = 'ipython',
  r = 'R',
  vim = 'nvim --clean -ERM',
}
