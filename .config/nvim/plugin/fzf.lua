-- used to keyset fzf with different search lists
-- https://github.com/junegunn/fzf/blob/master/README-VIM.md#fzfwrap
fzf_on = function(shell_cmd)
    vim.fn["fzf#run"](vim.fn["fzf#wrap"]({
        options = "--preview 'cat {}'",
        sink = "e",
        source = shell_cmd
    }))
end
