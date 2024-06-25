-- settings
-- see https://neovim.io/doc/user/quickref.html#option-list
-- vim.opt could be helpful for modifying options in functions, as it has methods

vim.cmd.set('splitbelow splitright number relativenumber nowrap mouse=a encoding=utf8 clipboard=unnamedplus,unnamed')

-- cursorline for active windows only
vim.cmd [[
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
]]

-- tab characters and spaces: first and last line set default, middle lines set exceptions
vim.cmd [[
    set expandtab tabstop=4 shiftwidth=4
    autocmd BufEnter *.R set tabstop=2|set shiftwidth=2
    autocmd BufEnter *.rmd set tabstop=2|set shiftwidth=2
    autocmd BufLeave * set tabstop=4|set shiftwidth=4
]]

-- colors: see https://www.ditig.com/256-colors-cheat-sheet
vim.cmd [[
    highlight TabLineFill cterm=NONE ctermbg=237
    highlight TabLine cterm=NONE ctermbg=237 ctermfg=39
    highlight TabLineSel cterm=NONE ctermbg=Black ctermfg=13
    highlight CursorLine cterm=NONE ctermbg=237
    highlight VertSplit cterm=NONE
]]
