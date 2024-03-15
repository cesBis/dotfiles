-- settings
-- see https://neovim.io/doc/user/quickref.html#option-list

local set = vim.opt

set.splitbelow = true
set.splitright = true
set.clipboard = 'unnamedplus,unnamed'
set.encoding = 'utf8'
set.wrap = false
set.mouse = 'a'

set.number = true
set.relativenumber = true
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber')

-- cursorline for active windows only
vim.cmd('autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline')
vim.cmd('autocmd WinLeave * setlocal nocursorline')

-- tab character to spaces
---- default
set.expandtab = true
set.tabstop = 4
set.shiftwidth = 4
---- 2 spaces for R, reset to default on exit
vim.cmd [[
    autocmd BufEnter *.R set tabstop=2|set shiftwidth=2
    autocmd BufEnter *.rmd set tabstop=2|set shiftwidth=2
    autocmd BufLeave * set tabstop=4|set shiftwidth=4
]]

-- colors: see https://www.ditig.com/256-colors-cheat-sheet
vim.cmd [[
    highlight TabLineFill cterm=NONE ctermbg=Black
    highlight TabLine cterm=NONE ctermbg=Black
    highlight TabLineSel cterm=NONE ctermbg=237
    highlight CursorLine cterm=NONE ctermbg=237
    highlight VertSplit cterm=NONE
]]

