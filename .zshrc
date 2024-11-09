# secrets go in ~/.zshenv, which is .gitignored

export EDITOR=nvim
export LANG=en_US.UTF-8

alias lv='ls -hlsA'
alias la='ls -A'
alias bat='batcat' # see `apt show bat` and/or https://github.com/sharkdp/bat?tab=readme-ov-file#on-ubuntu-using-apt

export ZPLUG_HOME=$HOME/.local/share/zsh/zplug
# zplug came from apt
. /usr/share/zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "hlissner/zsh-autopair"
zplug "zsh-users/zsh-history-substring-search"
zplug load

if ! zplug check; then
  zplug install
fi

export HISTORY_SUBSTRING_SEARCH_FUZZY=1
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

############################################
# Completions
############################################

autoload -Uz compinit
zmodload zsh/complist
zstyle ':completion:*' menu select
compinit
_comp_options+=(globdots)

if [ -d ~/.local/share/zsh/completions ]; then
  for f in `ls ~/.local/share/zsh/completions`; do
      source ~/.local/share/zsh/completions/$f
  done
fi

############################################
# Miscelaneous (see `man zshoptions`)
############################################

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=10000
setopt inc_append_history_time hist_ignore_dups extended_history

setopt autocd extendedglob
unsetopt BEEP

autoload -Uz colors && colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

############################################
# Prompt and Vim Mode
############################################

# https://salferrarello.com/zsh-git-status-prompt/
autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats       '%F{45}[%b]%f'
zstyle ':vcs_info:git:*' actionformats '%F{45}[%b:%a]%f'
# ignore dotfile repos, see https://unix.stackexchange.com/a/563964
zstyle ':vcs_info:git:*:conner' formats "%0.0r"
zstyle ':vcs_info:git:*:.devbox' formats "%0.0r"
PROMPT='%F{39}[%~]%f${vcs_info_msg_0_}%F{13}>%f '

# https://github.com/ChristianChiarulli/Machfiles/blob/4bd368358eb9a4ace2bc99daf52548925f9507e3/zsh/.config/zsh/zsh-vim-mode

bindkey -v
# allow backspace past where you entered insert mode
bindkey "^?" backward-delete-char

# Ctrl + vi-keys in tab complete menu
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[2 q';;      # block
        viins|main) echo -ne '\e[6 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.
