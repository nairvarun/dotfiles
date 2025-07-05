# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Enable case-insensitive tab completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# vim mode
bindkey -v
bindkey "^R" history-incremental-search-backward

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

# source secrets
source "$HOME/.secrets"

# path
export PATH="$HOME/.local/bin:$PATH"

# postgresql
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
