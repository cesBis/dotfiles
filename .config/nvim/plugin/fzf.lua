-- https://github.com/junegunn/fzf/blob/master/README-VIM.md

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

fzf_find_in_git_files = function(term)
    fzf({
        sink = "e",
        source = "git grep " .. term .. " | cut -d : -f 1 | sort | uniq",
        options = "--preview 'grep --line-number \"" .. term .. "\" {}'",
    })
end
