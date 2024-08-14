-- https://github.com/Robitx/gp.nvim
require("gp").setup({
  providers = {
    copilot = {disabled = false},
    openai = {disabled = true},
  },
  chat_template = require("gp.defaults").short_chat_template,
  chat_shortcut_respond = {modes = {}, shortcut = ''},
  chat_shortcut_delete = {modes = {}, shortcut = ''},
  chat_shortcut_stop = {modes = {}, shortcut = ''},
  chat_shortcut_new = {modes = {}, shortcut = ''},
})
