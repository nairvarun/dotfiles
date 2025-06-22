# Enable case-insensitive tab completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# starship prompt
eval "$(starship init zsh)"

# alias
alias g="git"
alias p="python3"
alias venv="source ./.venv/bin/activate"
alias t="tmux"
alias sc="source ~/.zshrc"

# functions
# mkdir and then cd into it
mkcd() {
  mkdir "$1" -p
  cd "$1"
}

# path
export PATH="$HOME/.local/bin:$PATH"
