#!/bin/bash

# vi mode
set -o vi

# set vi as default text editor
export EDITOR="/bin/vi"

# my prompt
if [ -f ~/.bashrc.d/prompt.sh ]; then
  . ~/.bashrc.d/prompt.sh
fi

# # starship prompt
# eval "$(starship init bash)"

# hack to fix clock issue due windows dual boot
timedatectl set-local-rtc 1 --adjust-system-clock

# mkdir and then cd into it
mkcd() {
  mkdir $1
  cd $1
}

# source bashrc
alias sbc=". ~/.bashrc"

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
  . /usr/share/bash-completion/completions/git
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
if [ -f ~/.bashrc.d/python.sh ] && command -v python3 > /dev/null; then
  . ~/.bashrc.d/python.sh
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
  . <(kubectl completion bash)
  alias k='kubectl'
  complete -o default -F __start_kubectl k
fi

# kind
if command -v kind > /dev/null; then
  . <(kind completion bash)
fi

# minikube
# https://minikube.sigs.k8s.io/docs/commands/completion/
if command -v minikube > /dev/null; then
  . <(minikube completion bash)
fi

# neovim
alias lazyvim="NVIM_APPNAME=nvim/LazyVim nvim"
# alias astronvim="NVIM_APPNAME=nvim/AstroNvim nvim"
# alias nvchad="NVIM_APPNAME=nvim/NvChad nvim"

# onefetch config
if [ -f ~/.bashrc.d/onefetch.sh ] && command -v onefetch > /dev/null; then
  . ~/.bashrc.d/onefetch.sh
fi
