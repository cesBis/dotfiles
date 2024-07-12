-- settings
-- see https://neovim.io/doc/user/quickref.html#option-list
-- vim.opt could be helpful for modifying options in functions, as it has methods

vim.cmd.set('splitbelow splitright number relativenumber nowrap mouse=a encoding=utf8 clipboard=unnamedplus,unnamed ignorecase smartcase')

-- tab characters and spaces: first and last line set default, middle lines set exceptions
vim.cmd [[
  set expandtab tabstop=2 shiftwidth=2
  autocmd BufEnter *.py set tabstop=4|set shiftwidth=4
  autocmd BufLeave * set tabstop=2|set shiftwidth=2
]]
