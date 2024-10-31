-- https://github.com/Robitx/gp.nvim
require("gp").setup({
  providers = {
    copilot = {disabled = false},
    openai = {disabled = true},
  },
  agents = {
    -- a ChatCopilot agent is provided by default
    -- change agents with :GpAgent ChatCopilot
    -- agent choice is persisted on disk across sessions
    {
      provider = "copilot",
      name = "DocBot",
      chat = true,
      command = false,
      model = { model = "gpt-4o", temperature = 0.3, top_p = 1 },
      system_prompt = "You are a customized internet search engine for a computer programmer.\n\n"
      .. "The user provided a search phrase or query:\n\n"
      .. "- Always start your response with a markdown formatted list of valid links. Prioritize official documentation.\n"
      .. "- When reasonable, proceed to provide example code.\n"
      .. "- When reasonable, conclude your response with a concise summary to aid the user.\n"
    }
  },
  chat_template = require("gp.defaults").short_chat_template,
  -- disabling shortcuts in favor of custom commands below
  chat_shortcut_respond = {modes = {}, shortcut = ''},
  chat_shortcut_delete = {modes = {}, shortcut = ''},
  chat_shortcut_stop = {modes = {}, shortcut = ''},
  chat_shortcut_new = {modes = {}, shortcut = ''},
})

vim.api.nvim_create_user_command("Botstart", ":GpChatNew tabnew", {})
vim.api.nvim_create_user_command("Botresponse", ":GpChatRespond", {})
