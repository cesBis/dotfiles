require 'fzf'
require('lualine').setup(require('lualine_conf'))
require('gp').setup(require('gp_conf'))
require('outline').setup()

require("ccc").setup { highlighter = { auto_enable = true } }

-- https://github.com/pappasam/nvim-repl
require("repl").setup {
  default = { cmd = "zsh" },
  open_window_default = "new",
}

require("oil").setup {
  default_file_explorer = false, -- true breaks :GBrowse
  skip_confirm_for_simple_edits = true,
  view_options = { show_hidden = true },
}

require('blink.cmp').setup {
  keymap = {
    preset = 'none',
    ['<TAB>'] = {'select_next', 'fallback'},
    ['<S-TAB>'] = {'select_prev', 'fallback'},
  },
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
}
