#!/bin/bash

BLACK='\[\e[30m\]'
RED='\[\e[31m\]'
GREEN='\[\e[32m\]'
YELLOW='\[\e[33m\]'
BLUE='\[\e[34m\]'
MAGENTA='\[\e[35m\]'
CYAN='\[\e[36m\]'
WHITE='\[\e[37m\]'
ENDC='\[\e[m\]'

_k8s() {
  CLUSTER=$(kubectl config current-context 2> /dev/null)
  if [ -n "$CLUSTER" ]; then
    echo "[$CLUSTER]"
  else
    echo ""
  fi
}

_git() {
  BRANCH=$(git branch --show-current 2> /dev/null)
  if [ -n "$BRANCH" ]; then
    if [ -z "$(git status --porcelain)" ]; then
      STAT=""
    else
      STAT="*"
    fi
      echo "[${BRANCH}${STAT}]"
  else
    echo ""
  fi
}

_tmux() {
  if [ ! "$(echo $TMUX)" == "" ]; then
    echo "'"
  else
    echo ""
  fi
}

_pyvenv() {
  if [ -z "$VIRTUAL_ENV" ]; then
    echo ""
  else
    echo [`basename $VIRTUAL_ENV`]
  fi
}

export PS1="$RED\`_pyvenv\`$ENDC$MAGENTA(\`_tmux\`\W)$ENDC$GREEN\`_git\`$ENDC$BLUE\`_k8s\`$ENDC "

# . ~/.bashrc.d/git-prompt.sh
# GIT_PS1_SHOWDIRTYSTATE=0
# GIT_PS1_SHOWSTASHSTATE=0
# GIT_PS1_SHOWUNTRACKEDFILES=0
# GIT_PS1_SHOWUPSTREAM=0
# GIT_PS1_SHOWCONFLICTSTATE="yes"
# GIT_PS1_SHOWCOLORHINTS=0
# GIT_PS1_STATESEPARATOR=''
# export PS1='[$(_pyvenv "(%s )")\W$(__git_ps1 " (%s)")] '

