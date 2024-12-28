if os.getenv('OLLAMA_HOST') then ollama_host = os.getenv('OLLAMA_HOST') else ollama_host = '' end

-- https://github.com/Robitx/gp.nvim
require("gp").setup({
  chat_shortcut_respond = {modes = {'i'}, shortcut = '<cr>'},
  chat_shortcut_delete = {modes = {}, shortcut = ''},
  chat_shortcut_stop = {modes = {'i'}, shortcut = 'x'},
  chat_shortcut_new = {modes = {'i'}, shortcut = '<C-n>'},
  providers = {
    copilot = {disabled = false},
    ollama = {
      endpoint = "http://" .. ollama_host .. "/v1/chat/completions",
      disabled = false,
    },
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
    },
    {
      provider = "ollama",
      name = "Llama",
      chat = true,
      command = false,
      model = { model = "llama3.1", temperature = 0.3, top_p = 1 },
      system_prompt = "You are an assistant to a computer programmer."
                   .." An expert in related documentation, including docs.python.org, and the unix `man` pages."
                   .." Please help me find related documentation."
                   .." Help by providing reference examples, and discussing ideas."
                   .." Be concise."
                   .." Don't provide advice."
                   .." Use examples to introduce concepts and key words."
                   .." Conclude with a short list of related keywords for searching. "
    }
  },
  chat_template = require("gp.defaults").short_chat_template,
})
