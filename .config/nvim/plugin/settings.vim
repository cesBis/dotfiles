set splitbelow splitright number relativenumber nowrap mouse=a encoding=utf8 clipboard=unnamedplus,unnamed ignorecase smartcase
let g:netrw_banner=0

" cursorline for active windows only
autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" tab characters and spaces: first and last line set default, middle lines set exceptions
set expandtab tabstop=2 shiftwidth=2
autocmd BufEnter *.py set tabstop=4|set shiftwidth=4
autocmd BufLeave * set tabstop=2|set shiftwidth=2

" colors: see https://www.ditig.com/256-colors-cheat-sheet
" see :h colorscheme if you're ever compelled to enable switching colorschemes
highlight TabLineFill cterm=NONE ctermbg=237
highlight TabLine cterm=NONE ctermbg=237 ctermfg=39
highlight TabLineSel cterm=NONE ctermbg=Black ctermfg=13
highlight CursorLine cterm=NONE ctermbg=237
highlight VertSplit cterm=NONE
