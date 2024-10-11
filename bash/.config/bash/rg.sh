#!/bin/bash

# # fzf
# # colors + search hidden files ignoring .git/
# export FZF_DEFAULT_COMMAND="find \( -name '.venv' -o -name '.git' -o -name 'node_modules' \) -prune -o -print"
# # --preview '(bat {} --style numbers,changes --color=always--style numbers,changes --color=always || tree {}) 2> /dev/null' \
# # dafault
# export FZF_DEFAULT_OPTS="--bind=alt-k:up,alt-j:down,alt-K:preview-page-up,alt-J:preview-page-down"
# # catppuccin
# # export FZF_DEFAULT_OPTS="--bind=alt-k:up,alt-j:down,alt-K:preview-page-up,alt-J:preview-page-down \
# #              --color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD \
# #              --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 \
# #              --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD"
# export FZF_COMPLETION_TRIGGER=','

# # ripgrep
# # search hidden files ignoring .git/
# alias rg="rg --hidden --glob '!.git' --glob '!.venv' --glob '!node_modules'"

# # fzf ==> cd
# alias cdf='cd $(find \( -name ".venv" -o -name ".git" -o -name "node_modules" \) -prune -o -type d -print | fzf)'

# # fzf and ripgrep ==> vi
# edit_fzf()
# {
#   # if in tmux
#   if [ "$TMUX" != "" ] && [ "$1" != "" ]
#   then
#   if [ "$1" = "sv" ]
#   then
#     fzf -e | xargs -r echo $EDITOR | xargs -r tmux split-window -vd
#   elif [ "$1" = "s" ]
#   then
#     fzf -e | xargs -r echo $EDITOR | xargs -r tmux split-window -hd
#   elif [ "$1" = "n" ]
#   then
#     fzf -e | xargs -r echo $EDITOR | xargs -r tmux new-window -d
#   else
#     fzf -e | xargs -r $EDITOR
#   fi
#   else
#   fzf -e | xargs -r $EDITOR
#   fi
# }
# alias eff=edit_fzf

# edit_rg()
# {
#   # if in tmux
#   if [ "$TMUX" != "" ] && [ "$1" != "" ]
#   then
#   if [ "$1" = "sv" ]
#   then
#     rg . | fzf --print0 -e | sed "s/:.*//" | xargs -r echo $EDITOR | xargs -r tmux split-window -vd
#   elif [ "$1" = "s" ]
#   then
#     rg . | fzf --print0 -e | sed "s/:.*//" | xargs -r echo $EDITOR | xargs -r tmux split-window -hd
#   elif [ "$1" = "n" ]
#   then
#     rg . | fzf --print0 -e | sed "s/:.*//" | xargs -r echo $EDITOR | xargs -r tmux new-window -d
#   else
#     rg . | fzf --print0 -e | sed "s/:.*//" | xargs -r $EDITOR
#   fi
#   else
#   rg . | fzf --print0 -e | sed "s/:.*//" | xargs -r $EDITOR
#   fi
# }
# alias erg=edit_rg
