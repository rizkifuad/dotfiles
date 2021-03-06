source $HOME/.zgen/zgen.zsh
# Zgen init
if ! zgen saved; then
    echo "Creating a zgen save"
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/autojump
    zgen load zsh-users/zsh-completions src
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen save
fi
# Source private config
source $HOME/.config/zsh/private.zsh
# Custom prompt
source $HOME/.config/zsh/prompt.zsh
# Kubectl prompt
source $HOME/.config/zsh/kubectl.zsh
alias k=kubectl
complete -F __start_kubectl k

# Dotfiles bare repo
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias d="dotfiles"
alias da="dotfiles add"
alias dcommit="dotfiles commit -m"
alias dpush="dotfiles push origin master"
alias dpull="dotfiles pull origin master"
# Quick systemctl
alias ss="sudo systemctl start"
alias sr="sudo systemctl restart"
alias sst="sudo systemctl status"
alias se="sudo systemctl enable"
alias sx="sudo systemctl stop"
# Tmux quick attach
alias tma="tmux attach -t $1"
# vim to neovim
# alias vim=nvim
# alias kubectl="sudo kubectl"
alias open="xdg-open"
alias plantuml="plantuml -config $HOME/.config/plantuml"
#alias katarun="source env && katarun && nodemon start.local.js"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Global editor config
export VISUAL=nvim
export EDITOR=nvim

bindkey -v # Vim keybinding
bindkey -M vicmd v edit-command-line
autoload zkbd
typeset -g -A key

# History smart search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
bindkey "^P" up-line-or-beginning-search # Up
bindkey "^N" down-line-or-beginning-search # Down

SSH_ENV=$HOME/.ssh/environment

# FZF config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs'
# export FZF_DEFAULT_OPTS="
# --color fg:188,bg:0,hl:103,fg+:222,bg+:0,hl+:104
# --color info:183,prompt:110,spinner:107,pointer:167,marker:215
# "

# Quickly setup dev env 
alias tide="tmux split-window -v -p 30 && tmux split-window -h -p 50 && tmux select-pane -t 0"

# History config
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

fpath+=${ZDOTDIR:-~}/.zsh_functions
fpath+=${ZDOTDIR:-~}/.zsh_functions
fpath+=${ZDOTDIR:-~}/.zsh_functions
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Lang config
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_MESSAGES="C"
export LC_CTYPE=C 
export LANG=C

export ANDROID_HOME=$HOME/Android/Sdk
# export KUBECONFIG=/etc/rancher/k3s/k3s.yaml:~/.kube/pil
export KUBECONFIG=~/.kube/pil:~/.kube/config
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export GO111MODULE=auto

export PATH=$PATH:$HOME/flutter/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$GOBIN
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.gem/ruby/2.7.0/bin

alias pbcopy="xclip -selection clipboard"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
