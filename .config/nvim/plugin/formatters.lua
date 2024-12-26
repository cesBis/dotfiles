vim.fn.system("which ruff")
if vim.v.shell_error == 0 then
  vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
      pattern = "*.py",
      callback = function()
        os.execute("ruff format --quiet " .. vim.fn.expand("%"))
        vim.cmd.edit(vim.fn.expand("%"))
      end
    }
  )
end
