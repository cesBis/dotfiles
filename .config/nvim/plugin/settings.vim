set splitbelow splitright number relativenumber nowrap mouse=a encoding=utf8 clipboard=unnamedplus,unnamed ignorecase smartcase
let g:netrw_banner=0

" cursorline for active windows only
autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" tab characters: default nvim file type plugins sometimes override these, despite the readme saying they shouldn't
" see https://github.com/neovim/neovim/blob/v0.9.5/runtime/ftplugin
set expandtab tabstop=2 shiftwidth=2

" see :h colorscheme if you're ever compelled to enable switching colorschemes
" colors: see https://www.ditig.com/256-colors-cheat-sheet
highlight TabLineFill cterm=NONE ctermbg=237
highlight TabLine cterm=NONE ctermbg=237 ctermfg=39
highlight TabLineSel cterm=NONE ctermbg=Black ctermfg=13
highlight CursorLine cterm=NONE ctermbg=237
highlight VertSplit cterm=NONE
