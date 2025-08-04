# secrets go in ~/.zshenv, which is .gitignored

export EDITOR=nvim
export LANG=en_US.UTF-8
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive # https://nixos.wiki/wiki/Locales

alias ls='ls --group-directories-first'
alias lv='ls -hlsA --group-directories-first'
alias la='ls -A --group-directories-first'
# see https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh
alias g='git'
alias ga='git add'
alias gapa='git add --patch'
alias gau='git add --update'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gc='git commit --verbose'
alias gd='git diff'
alias gf='git fetch'
alias gl='git log'
alias glo='git log --oneline --decorate'
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gpl='git pull'
alias gpr='git pull --rebase'
alias gps='git push'
alias grm='git rm'
alias gstall='git stash --all'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gst='git status'
alias gss='git status --short'
alias gsb='git status --short --branch'
alias gsw='git switch'
alias gswc='git switch --create'
alias gswd='git switch $(git_develop_branch)'
alias gswm='git switch $(git_main_branch)'

############################################
# Completions
############################################

# some programs install their own completions
fpath+=/usr/share/zsh/site-functions

autoload -Uz compinit
zmodload zsh/complist
zstyle ':completion:*' menu select
compinit
_comp_options+=(globdots)

############################################
# Miscelaneous (see `man zshoptions`)
############################################

HISTFILE=~/.zsh_history
HISTSIZE=31000
SAVEHIST=30000
setopt share_history hist_ignore_dups

setopt autocd extendedglob
unsetopt BEEP

autoload -Uz colors && colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
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

############################################
# Plugins
############################################

if [ $(echo $PATH | cut -d : -f 1) != ~/.nix-profile/bin ] && [ -e ~/.nix-profile/etc/profile.d/nix.sh ]
then
  . ~/.nix-profile/etc/profile.d/nix.sh
fi

if [ $(echo $PATH | cut -d : -f 1) = ~/.nix-profile/bin ]
then
  # setup for neovim chatbot plugin robitx/gp.nvim
  # it seems codespaces rotates GITHUB_TOKEN, so this needs executed once per codespace login
  # maybe move to ~/.profile instead, to avoid reexecuting with every tmux pane
  [ ! -e ~/.config/github-copilot ] && mkdir ~/.config/github-copilot
  [ -n "$CODESPACES" ] && echo '{"github.com":{"user":"'$GITHUB_USER'","oauth_token":"'$GITHUB_TOKEN'"}}' > ~/.config/github-copilot/hosts.json

  fpath+=~/.nix-profile/share/zsh/site-functions
  . ~/.nix-profile/share/fzf/completion.zsh
  . ~/.nix-profile/share/fzf/key-bindings.zsh
  . ~/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  # zsh-syntax-highlighting must come last
  # https://github.com/zsh-users/zsh-syntax-highlighting?tab=readme-ov-file#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file
  . ~/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
