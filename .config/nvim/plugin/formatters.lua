vim.fn.system("which ruff")
if vim.v.shell_error == 0 then
  vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
      pattern = "*.py",
      callback = function()
        os.execute("ruff format --quiet")
        vim.cmd.edit(vim.fn.expand("%"))
      end
    }
  )
end

vim.fn.system("R -s -e \"find.package('styler')\"")
if vim.v.shell_error == 0 then
  vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
      pattern = "*.R",
      callback = function()
        os.execute("R -s -e \"options('styler.quiet' = TRUE);styler::style_file('" .. vim.fn.expand("%") .. "')\"")
        vim.cmd.edit(vim.fn.expand("%"))
      end
    }
  )
end
