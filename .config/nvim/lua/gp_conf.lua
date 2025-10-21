if os.getenv('OLLAMA_HOST') then ollama_host = os.getenv('OLLAMA_HOST') else ollama_host = '' end

local prompt = "You are an experienced computer programmer."
            .." An excellent mentor and helpful assistant, but terse, blunt, and focused."
            .." An expert in related documentation, including docs.python.org, and the unix `man` pages."
            .." Please help me find related documentation."
            .." Help by providing reference examples, and discussing ideas."
            .." Be concise."
            .." Don't provide advice."
            .." Use examples to introduce concepts and **keywords**."

-- https://github.com/Robitx/gp.nvim
return {

  chat_shortcut_respond = {modes = {'i'}, shortcut = '<cr>'},
  chat_shortcut_stop = {modes = {'n'}, shortcut = '<ESC>'},
  chat_shortcut_delete = {modes = {}, shortcut = ''},
  chat_shortcut_new = {modes = {}, shortcut = ''},

  chat_confirm_delete = false,
  chat_free_cursor = true,
  chat_template = require("gp.defaults").short_chat_template,

  providers = {
    copilot = {disabled = false},
    ollama = {disabled = false, endpoint = "http://" .. ollama_host .. "/v1/chat/completions"},
    openai = {disabled = true},
  },

  agents = {
    -- change agents with :GpAgent name
    -- agent choice is persisted on disk across sessions
    {
      provider = "copilot",
      name = "CustomCopilotClaude",
      chat = true,
      command = false,
      -- see premium request usage at https://github.com/settings/copilot/features
      model = { model = "claude-sonnet-4.5" },
      system_prompt = prompt
    },
    {
      provider = "copilot",
      name = "CustomCopilotGpt5",
      chat = true,
      command = false,
      -- see premium request usage at https://github.com/settings/copilot/features
      model = { model = "gpt-5" },
      system_prompt = prompt
    },
    {
      provider = "copilot",
      name = "CustomCopilotGpt5mini",
      chat = true,
      command = false,
      -- this one doesn't use premium requests https://docs.github.com/en/copilot/concepts/billing/copilot-requests#model-multipliers
      model = { model = "gpt-5-mini" },
      system_prompt = prompt
    },
    {
      provider = "ollama",
      name = "ChatMyLlama",
      chat = true,
      command = false,
      model = { model = "gemma2", temperature = 0.4, top_p = 1 },
      system_prompt = prompt
    },
  }
}
