-- custom commands which depend only on base nvim or packages
-- commands leveraging plugins belong in the relevant plugin/ file

local macro = vim.api.nvim_create_user_command

macro("Spellcheck1ON", ":setlocal spell spelllang=en_us", {})
macro("Spellcheck2OFF", ":setlocal nospell", {})
macro("Help", ":tab help", {nargs=1})

-- :Git from vim-fugitive
macro("Commit", ":Git add --update | tab Git commit --verbose", {})
