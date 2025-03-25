" standard settings
set number relativenumber nowrap ignorecase smartcase clipboard=unnamedplus,unnamed updatetime=300
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
nmap <leader>l <cmd>nohl<cr><cmd>echo<cr>

set rtp+=~/programs/fzf
nmap <leader>f <cmd>FZF<cr>

" nvim-qt
if has('gui_running')
  set wrap

  nmap j gj
  nmap k gk

  " default to notes rather than welcome screen
  autocmd VimEnter *  if len(argv()) == 0 && !&modified && empty(&buftype) && line('$') == 1 && getline(1) == '' | cd ~/notes | edit overview.md | endif

  " change font with scroll
  let s:fontsize = 12
  function! AdjustFontSize(amount)
    let s:fontsize = s:fontsize+a:amount
    :execute "GuiFont! Hack Nerd Font:h" . s:fontsize
  endfunction
  noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
  noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
  inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
  inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a
endif
