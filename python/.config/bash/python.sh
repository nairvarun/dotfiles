#!/bin/bash

# disable the default `(.venv)` inserted before $PS1 when virtual env is active.
# (our custom $PS1 will display the venv properly)
export VIRTUAL_ENV_DISABLE_PROMPT=1

# `p` will execute the passed file
# `p` will start repl if no file is passed
# if the exit code == 1, it will run `ohhnoo`
function p {
  python3 -q $@
  if [ $? == 1 ]; then
    ohhnoo
  fi
}

# activate .venv if .venv dir is present
# create and activate virtual env if in root of git repo
function venv {
  if [ "$VIRTUAL_ENV" == "" ]; then
    if [ -d "./.venv/" ]; then
      source ./.venv/bin/activate
    elif [ -d "./.git/" ]; then
      python3 -m venv .venv && source ./.venv/bin/activate
      # echo .venv >> .gitignore
    fi
  else
    deactivate
  fi
}

# alias p="python3 -q"
alias pin="python -i "
alias pi="pip install"

alias pipr="pip install -r requirements.txt"
alias pipf="pip freeze >> requirements.txt"

alias ipython="ipython --no-banner --InteractiveShell.editing_mode=vi"
# alias ipython="ipython --no-banner --InteractiveShell.editing_mode=vi --InteractiveaShellApp.extensions="['autoreload']""

