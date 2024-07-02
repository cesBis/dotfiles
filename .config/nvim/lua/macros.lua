local macro = vim.api.nvim_create_user_command

-- spellcheck
macro("Spellcheck", ":setlocal spell spelllang=en_us", {})
macro("Nospellcheck", ":setlocal nospell", {})

-- vim-fugitive shortcuts
macro("Commit", ":Git add --update | tab Git commit --verbose", {})

-- fzf wrapper
-- used to keyset fzf with different search lists
-- https://github.com/junegunn/fzf/blob/master/README-VIM.md#fzfwrap
fzf_on = function(shell_cmd)
    vim.fn["fzf#run"](vim.fn["fzf#wrap"]({
        options = "--preview 'cat {}'",
        sink = "e",
        source = shell_cmd
    }))
end
