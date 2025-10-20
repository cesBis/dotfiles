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

require('blink.cmp').setup({
  keymap = require('keys').blink_keymap,
  completion = {list = {selection = {preselect = false, auto_insert = true}}},
})

copilot_setup = function(opt)
  require('copilot').setup({
    suggestion = {
      auto_trigger = true,
      keymap = require('keys').copilot_keymap
    },
    server = { type = "binary", custom_server_filepath = "copilot-language-server"}
  })
end
