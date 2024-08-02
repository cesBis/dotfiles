set splitbelow splitright number relativenumber nowrap mouse=a encoding=utf8 clipboard=unnamedplus,unnamed ignorecase smartcase
set statusline=%-F%=%{&fileencoding}\ \ %{&fileformat}

" cursorline for active windows only
autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" tab characters and spaces: first and last line set default, middle lines set exceptions
set expandtab tabstop=2 shiftwidth=2
autocmd BufEnter *.py set tabstop=4|set shiftwidth=4
autocmd BufLeave * set tabstop=2|set shiftwidth=2

" colors
highlight statusline cterm=NONE gui=NONE
highlight TabLineFill cterm=NONE ctermbg=237
highlight TabLine cterm=NONE ctermbg=237 ctermfg=39
highlight TabLineSel cterm=NONE ctermbg=Black ctermfg=13
highlight CursorLine cterm=NONE ctermbg=237
highlight VertSplit cterm=NONE

" keys
let mapleader = " "
nmap <leader>- <cmd>split<cr>
nmap <leader>\ <cmd>vsplit<cr>
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" nvim-repl installed with
" git clone https://github.com/pappasam/nvim-repl $HOME/AppData/Local/nvim/pack/github/start/nvim-repl
" exit terminal with Ctrl+q
tmap <C-q> <C-\><C-n>
let g:repl_split = "bottom"
nmap <leader>t <cmd>ReplToggle<cr>
nmap <leader>r <Plug>ReplSendLine<C-j>i<cr><C-q><C-k>
xmap <leader>r <Plug>ReplSendVisual<C-j>i<cr><C-q><C-k>
" see :h shell-powershell
let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
let &shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
set shellquote= shellxquote=
