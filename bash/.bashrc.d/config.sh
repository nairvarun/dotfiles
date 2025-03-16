#!/bin/bash

# vi mode
set -o vi

# set vi as default text editor
export EDITOR="/snap/bin/nvim"

# set LS_COLORS
eval "$(dircolors -b ~/.bashrc.d/DIR_COLORS)"

# longer history
export HISTSIZE=5000
export HISTFILESIZE=5000

# # my prompt
# if [ -f ~/.bashrc.d/prompt.sh ]; then
#   . ~/.bashrc.d/prompt.sh
# fi

# starship prompt
eval "$(starship init bash)"

# # hack to fix clock issue due windows dual boot
# timedatectl set-local-rtc 1 --adjust-system-clock

# load functions
if [ -d ~/.bashrc.d/functions ]; then
  for fn in ~/.bashrc.d/functions/*; do
    if [ -f "$fn" ]; then
      . "$fn"
    fi
  done
fi

# source bashrc
alias sbc=". ~/.bashrc"

# open stuff
alias xx="xdg-open $1 &>/dev/null"

# cd directly into dev directory
alias dev='cd ~/dev/'
alias wrk='cd ~/wrk/'

# scratch file
alias q='$EDITOR ~/notes/dump/$(date +%s).md'

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

# python config
if [ -f ~/.bashrc.d/python.sh ] && command -v python3 > /dev/null; then
  . ~/.bashrc.d/python.sh
fi

# go path
export PATH=$PATH:/usr/local/go/bin:/home/nv/go/bin

# run go files
if command -v go > /dev/null; then
  # ?? how will go be a command if path is not exported first??
  export PATH=$PATH:/usr/local/go/bin:/home/nv/go/bin

  function gr {
    go run $1.go
  }
fi

# neovim
if [ -d ~/.config/nvim/LazyVim ] && command -v nvim > /dev/null; then
  alias lazyvim="NVIM_APPNAME=nvim/LazyVim nvim"
fi

# onefetch config
if [ -f ~/.bashrc.d/onefetch.sh ] && command -v onefetch > /dev/null; then
  . ~/.bashrc.d/onefetch.sh
fi

# fzf config
if [ -f ~/.bashrc.d/fzf.sh ] && command -v fzf > /dev/null; then
  . ~/.bashrc.d/fzf.sh
fi

# aws completion
complete -C '/usr/local/bin/aws_completer' aws

