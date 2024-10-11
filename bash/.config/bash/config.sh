#!/bin/bash

# vi mode
set -o vi

export EDITOR="/bin/vi"

# prompt
source ~/.config/bash/prompt.sh

# mkdir and then cd into it
mkcd() {
  mkdir $1
  cd $1
}

# source bash config
alias sbc="source ~/.bashrc"

# open stuff
alias xx="xdg-open $1 &>/dev/null"

# cd directly into dev directory
alias dev='cd ~/dev/'

# scratch file
alias q="$EDITOR ~/.q.md"

# convenient ls
alias la="ls -a"
alias ll="ls -alh"

# git
if command -v git > /dev/null; then
  alias g='git'
  source /usr/share/bash-completion/completions/git
  __git_complete g __git_main
fi

# use 256 colors in tmux
if command -v tmux > /dev/null; then
  alias t='TERM=xterm-256color tmux -u'
fi

# force start btop even if no UTF-8 locale was detected
alias btop="btop --utf-force"

# get public ip
alias whatismyip="curl https://checkip.amazonaws.com/"

# restart pipewire
alias restart-pipewire='systemctl --user restart pipewire{,-pulse}.socket'

# python config
if command -v python3 > /dev/null; then
  source ~/.config/bash/python.sh
fi

# run go files
if command -v go > /dev/null; then
  export PATH=$PATH:/usr/local/go/bin:/home/nv/go/bin

  function gr {
    go run $1.go
  }
fi

# docker
if command -v docker > /dev/null; then
  alias d='docker'
fi

# kubectl
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#enable-shell-autocompletion
if command -v kubectl > /dev/null; then
  source <(kubectl completion bash)
  alias k='kubectl'
  complete -o default -F __start_kubectl k
fi

# kind
if command -v kind > /dev/null; then
  source <(kind completion bash)
fi

# minikube
# https://minikube.sigs.k8s.io/docs/commands/completion/
if command -v kind > /dev/null; then
  source <(minikube completion bash)
fi

# neovim
alias lazyvim="NVIM_APPNAME=nvim/LazyVim nvim"
# alias astronvim="NVIM_APPNAME=nvim/AstroNvim nvim"
# alias nvchad="NVIM_APPNAME=nvim/NvChad nvim"

# hack to fix clock issue due windows dual boot
timedatectl set-local-rtc 1 --adjust-system-clock
