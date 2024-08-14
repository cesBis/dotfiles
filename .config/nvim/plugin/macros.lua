local macro = vim.api.nvim_create_user_command

-- spellcheck
macro("Spellcheck", ":setlocal spell spelllang=en_us", {})
macro("Nospellcheck", ":setlocal nospell", {})

-- vim-fugitive shortcuts
macro("Commit", ":Git add --update | tab Git commit --verbose", {})

-- gp.nvim
macro("Chatcall", ":GpChatNew tabnew", {})
macro("Chatreponse", ":GpChatRespond", {})
