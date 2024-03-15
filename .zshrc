export ZSH_CONF=$HOME/.config/zsh
export ZPLUG_HOME=$HOME/.local/share/zplug

. $ZSH_CONF/fancy-prompt
. $ZSH_CONF/general
. $ZSH_CONF/vim-mode
. $ZSH_CONF/zplug

alias lv='ls -hlsA'
alias la='ls -A'

export EDITOR=nvim
export VISUAL=nvim
export BROWSER=wslview
# unlike .Rprofile and .zshrc, python doesn't have a default startup script
export PYTHONSTARTUP=$HOME/.pyrc
# Default WSL Path has a bunch of stuff from windows that slows down tab autocomplete, so manually specify a shorter and relavant PATH.
export PATH=/home/conner/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/wsl/lib
# secrets go in ~/.zshenv, which is .gitignored
