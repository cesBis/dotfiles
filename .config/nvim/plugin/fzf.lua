-- https://github.com/junegunn/fzf/blob/master/README-VIM.md

fzf_spec_default = {
    options = "--preview 'cat {}'",
    sink = "e",
}

fzf_git_ls_files = function()
    local spec = fzf_spec_default
    spec["source"] = "git ls-files"
    vim.fn["fzf#run"](vim.fn["fzf#wrap"](spec))
end

fzf_all_files = function()
    local spec = fzf_spec_default
    spec["source"] = "find . -type f | cut -c 3- | sort"
    vim.fn["fzf#run"](vim.fn["fzf#wrap"](spec))
end

fzf_find_in_git_files = function(term)
    vim.fn["fzf#run"](vim.fn["fzf#wrap"]({
        sink = "e",
        source = "git grep " .. term .. " | cut -d : -f 1 | sort | uniq",
        options = "--preview 'grep --line-number \"" .. term .. "\" {}'",
    }))
end
