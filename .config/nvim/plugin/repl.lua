-- https://github.com/pappasam/nvim-repl
require('repl').setup({
  filetype_commands = {
    python = {cmd = 'ipython'},
    r = {cmd = 'R --quiet'},
    vim = {cmd = 'nvim --clean -ERM'},
  },
  default = {cmd = "zsh", filetype = "zsh"},
  open_window_default = "new",
})
