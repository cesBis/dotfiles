-- https://github.com/junegunn/fzf/blob/master/README-VIM.md
local fzf = function(spec) vim.fn["fzf#run"](vim.fn["fzf#wrap"](spec)) end

fzf_files = function()
  fzf({
    source = "find . "
      .. "-path './.git' -prune -o "
      .. "-path './.venv' -prune -o "
      .. "-path '*__pycache__' -prune -o "
      .. "-path './renv/library' -prune -o "
      .. "-type f -print | cut -c 3- | sort",
    options = "--preview 'cat {}'",
    sink = "e",
  })
end

fzf_dirs = function()
  fzf({
    source = "find . "
      .. "-path './.git' -prune -o "
      .. "-path './.venv' -prune -o "
      .. "-path '*__pycache__' -prune -o "
      .. "-path './renv/library' -prune -o "
      .. "-type d -print | tail +2 | cut -c 3- | sort",
    options = "--preview 'ls -A {}'",
    sink = "Oil",
  })
end

fzf_grep_in_git_files = function(term)
  fzf({
    source = "git grep '" .. term .. "' | cut -d : -f 1 | sort | uniq",
    options = "--preview 'grep --line-number --color=always \"" .. term .. "\" {}'",
    sink = "EditAndSearch " .. term
  })
end
