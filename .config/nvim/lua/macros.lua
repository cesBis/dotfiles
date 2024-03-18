local macro = vim.api.nvim_create_user_command

-- spellcheck
macro("Spellcheck", ":setlocal spell spelllang=en_us", {})
macro("Nospellcheck", ":setlocal nospell", {})
