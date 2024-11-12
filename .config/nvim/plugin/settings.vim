set splitright splitbelow number relativenumber nowrap ignorecase smartcase clipboard=unnamedplus,unnamed termguicolors
let g:netrw_banner=0

colorscheme quiet
highlight diffAdded   guifg=#00ff33
highlight diffRemoved guifg=#ff0033
autocmd ColorSchemePre * highlight clear

" cursorline for active windows only
autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" tab characters: default nvim file type plugins sometimes override these, despite the readme saying they shouldn't
" see https://github.com/neovim/neovim/blob/v0.9.5/runtime/ftplugin
set expandtab tabstop=2 shiftwidth=2
