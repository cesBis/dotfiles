-- https://github.com/pappasam/nvim-repl
vim.g.repl_split = "bottom"
vim.g.repl_filetype_commands = {
  python = 'ipython',
  r = 'R --quiet',
  vim = 'nvim --clean -ERM',
}
