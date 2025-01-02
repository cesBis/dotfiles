if os.getenv('OLLAMA_HOST') then ollama_host = os.getenv('OLLAMA_HOST') else ollama_host = '' end

-- https://github.com/Robitx/gp.nvim
require("gp").setup({

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
      name = "LinkCopilot",
      chat = true,
      command = false,
      model = { model = "gpt-4o", temperature = 0.3, top_p = 1 },
      system_prompt = "You are a customized internet search engine for a computer programmer.\n\n"
      .. "The user provided a search phrase or query:\n\n"
      .. "- Always start your response with a markdown formatted list of valid links. Prioritize official documentation.\n"
      .. "- When reasonable, proceed to provide example code.\n"
      .. "- When reasonable, conclude your response with a concise summary to aid the user.\n"
    },
    {
      provider = "copilot",
      name = "CodeDuckCopilot",
      chat = true,
      command = false,
      model = { model = "gpt-4o", temperature = 0.4, top_p = 1 },
      system_prompt = "You are an experienced computer programmer."
                   .." An excellent mentor and helpful assistant, but terse, blunt, and focused."
                   .." An expert in related documentation, including docs.python.org, and the unix `man` pages."
                   .." Please help me find related documentation."
                   .." Help by providing reference examples, and discussing ideas."
                   .." Be concise."
                   .." Don't provide advice."
                   .." Use examples to introduce concepts and **keywords**."
    },
    {
      provider = "ollama",
      name = "CodeDuckLlama",
      chat = true,
      command = false,
      model = { model = "gemma2", temperature = 0.4, top_p = 1 },
      system_prompt = "You are an experienced computer programmer."
                   .." An excellent mentor and helpful assistant, but terse, blunt, and focused."
                   .." An expert in related documentation, including docs.python.org, and the unix `man` pages."
                   .." Please help me find related documentation."
                   .." Help by providing reference examples, and discussing ideas."
                   .." Be concise."
                   .." Don't provide advice."
                   .." Use examples to introduce concepts and **keywords**."
    },
    -- disable default agents for more applicable tab completions
    {name = 'ChatCopilot', disable = true},
    {name = 'ChatGPT4o', disable = true},
    {name = 'ChatGPT4o-mini', disable = true},
    {name = 'ChatOllamaLlama3.1-8B', disable = true},
  }
})
