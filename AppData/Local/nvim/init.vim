set number relativenumber nowrap ignorecase smartcase clipboard=unnamedplus,unnamed
let g:netrw_banner=0
colorscheme quiet
set statusline=%-F%=%{&fileencoding}\ \ %{&fileformat}

" cursorline for active windows only
autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" tab characters: default nvim file type plugins sometimes override these, despite the readme saying they shouldn't
" see https://github.com/neovim/neovim/blob/v0.9.5/runtime/ftplugin
set expandtab tabstop=2 shiftwidth=2

" keys
let mapleader = " "
nmap <leader>- <cmd>split<cr>
nmap <leader>\ <cmd>vsplit<cr>
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
