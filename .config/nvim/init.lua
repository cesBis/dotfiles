require 'fzf'
require 'keys'
require('lualine').setup(require('lualine_conf'))
require('gp').setup(require('gp_conf'))
require("ccc").setup({highlighter = { auto_enable = true }})

require("oil").setup {
  -- true breaks :GBrowse
  default_file_explorer = false,
  skip_confirm_for_simple_edits = true,
  view_options = {
      show_hidden = true,
    },
}

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

vim.opt.signcolumn = 'yes'
vim.lsp.enable('r_language_server')
vim.lsp.enable('jedi_language_server')
vim.lsp.enable('marksman')
vim.lsp.enable('copilot')

require('blink.cmp').setup({
  keymap = require('keys').blink_keymap,
  completion = {list = {selection = {preselect = false, auto_insert = true}}},
  sources = {
    default = { 'copilot' , 'lsp', 'buffer', 'path'},
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-copilot",
        score_offset = 100,
        async = true,
      },
    },
  }
})
