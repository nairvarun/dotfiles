#### ZSH Settings
# vim mode
bindkey -v
bindkey "^R" history-incremental-search-backward

#### Aliases 
alias sc='source ~/.zshrc'
alias g="git"
alias p="python3"
alias venv="source ./.venv/bin/activate"
alias t="tmux"
alias tf="terraform"
alias d="docker"
alias k="kubectl"
alias h="helm"
alias kc="kubectl config use-context"
alias kn="kubectl config set-context --current --namespace"
alias lazygit='lazygit --use-config-file="/Users/nv/Library/Application Support/lazygit/config.yml,/Users/nv/Library/Application Support/lazygit/green.yml"'

#### Functions
# mkdir and then cd into it
mkcd() {
  mkdir -p -- "$1" && cd -- "$1"
}

#### EDITOR
EDITOR=/usr/bin/vim

#### PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

#### Completions
fpath=(
  $fpath
  ~/.zsh/completions 
  /Users/nv/.docker/completions 
)
autoload -Uz compinit
compinit -C -i -d ~/.zcompdump

# Enable case-insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# # gcloud
# source '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'
# source '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'

#### Software
# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# nvm
export NVM_DIR="$HOME/.nvm"

nvm() {
  unset -f nvm node npm npx
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  nvm "$@"
}

node() {
  unset -f nvm node npm npx
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  node "$@"
}

npm() {
  unset -f nvm node npm npx
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  npm "$@"
}

npx() {
  unset -f nvm node npm npx
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  npx "$@"
}
