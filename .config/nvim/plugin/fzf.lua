-- used to keyset fzf with different search lists

-- https://github.com/junegunn/fzf/blob/master/README-VIM.md#fzfwrap
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
