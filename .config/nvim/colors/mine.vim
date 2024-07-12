" cursorline for active windows only
set cursorline
autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" colors: see https://www.ditig.com/256-colors-cheat-sheet
highlight TabLineFill cterm=NONE ctermbg=237
highlight TabLine cterm=NONE ctermbg=237 ctermfg=39
highlight TabLineSel cterm=NONE ctermbg=Black ctermfg=13
highlight CursorLine cterm=NONE ctermbg=237
highlight VertSplit cterm=NONE
