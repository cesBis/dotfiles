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
macro("Glog",
  function(opt)
    vim.cmd("G log --oneline --decorate")
    open_commit_preview_to_the_right = vim.api.nvim_replace_termcodes("p:wincmd H<cr>", true, true, true)
    vim.api.nvim_feedkeys(open_commit_preview_to_the_right, "m", false)
    -- fugitive uses p for preview, but enter feels more natural here, so override for just this buffer
    vim.keymap.set('n', '<cr>', 'p', {buffer = true, remap = true})
  end,
  {}
)

-- :Repl from nvim-repl
macro("Z", "Repl zsh", {})

-- fzf -------------------------------
macro("EditAndSearch",
  function(opts)
    vim.cmd.edit(opts.fargs[#opts.fargs])
    vim.fn.feedkeys("/" .. opts.fargs[1] .. "\r", "n")
  end,
  {nargs = '+'}
)

macro("FzfGrepInGitFiles",
  function(opts)
    fzf_grep_in_git_files(opts.fargs[1])
  end,
  {nargs = 1}
)
