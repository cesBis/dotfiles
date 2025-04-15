if vim.fn.executable("ruff") == 1 then
  vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
      pattern = "*.py",
      callback = function()
        vim.fn.system("ruff format --quiet " .. vim.fn.expand("%"))
        vim.cmd.edit(vim.fn.expand("%"))
      end
    }
  )
end

if vim.fn.executable("air") == 1 then
  vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
      pattern = "*.R",
      callback = function()
        vim.fn.system("air format --quiet " .. vim.fn.expand("%"))
        vim.cmd.edit(vim.fn.expand("%"))
      end
    }
  )
end
