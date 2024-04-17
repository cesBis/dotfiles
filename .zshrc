export ZSH_CONF=$HOME/.config/zsh
export ZPLUG_HOME=$HOME/.local/share/zplug

. $ZSH_CONF/fancy-prompt
. $ZSH_CONF/general
. $ZSH_CONF/vim-mode
. $ZSH_CONF/zplug
. $ZSH_CONF/fzf

alias lv='ls -hlsA'
alias la='ls -A'
alias bat='batcat' # see `apt show bat` and/or https://github.com/sharkdp/bat?tab=readme-ov-file#on-ubuntu-using-apt

export EDITOR=nvim
# secrets go in ~/.zshenv, which is .gitignored
