-- https://github.com/junegunn/fzf/blob/master/README-VIM.md
-- fzf installed via apt
vim.cmd.source("/usr/share/doc/fzf/examples/fzf.vim")

local fzf = function(spec) vim.fn["fzf#run"](vim.fn["fzf#wrap"](spec)) end

fzf_git_ls_files = function()
  fzf({
    source = "git ls-files",
    options = "--preview 'cat {}'",
    sink = "e",
  })
end

fzf_all_files = function()
  fzf({
    source = "find . -type f | cut -c 3- | sort",
    options = "--preview 'cat {}'",
    sink = "e",
  })
end

fzf_grep_in_git_files = function(term)
  fzf({
    source = "git grep '" .. term .. "' | cut -d : -f 1 | sort | uniq",
    options = "--preview 'grep --line-number --color=always \"" .. term .. "\" {}'",
    sink = "e",
  })
end
vim.api.nvim_create_user_command("FzfGrepInGitFiles", function(opts) fzf_grep_in_git_files(opts.fargs[1]) end, {nargs = 1})
