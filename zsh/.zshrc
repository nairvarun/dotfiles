# Enable case-insensitive tab completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# starship prompt
eval "$(starship init zsh)"

# alias
alias g="git"
alias t="tmux"

