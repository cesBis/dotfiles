-- custom commands which depend only on base nvim or packages
-- commands leveraging plugins belong in the relevant plugin/ file

local macro = vim.api.nvim_create_user_command

macro("Spellcheck1ON", ":setlocal spell spelllang=en_us", {})
macro("Spellcheck2OFF", ":setlocal nospell", {})

-- :Git from vim-fugitive
macro("G",
  function(opts)
    vim.cmd("tab Git " .. opts.fargs[1])
  end,
  {nargs=1}
)
macro("Gcommit", ":G commit --all --verbose", {})
