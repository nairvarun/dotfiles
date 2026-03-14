#### ZSH Settings
# vim mode
bindkey -v
bindkey "^R" history-incremental-search-backward

#### Aliases 
alias sc='source ~/.zshrc'
alias scomp='rm ~/.zcompdump'
alias g="git"
alias lazygit='lazygit --use-config-file="/Users/nv/Library/Application Support/lazygit/config.yml,/Users/nv/Library/Application Support/lazygit/green.yml"'
alias p="python3"
alias venv="source ./.venv/bin/activate"
alias t="tmux"
alias tf="terraform"
alias d="docker"
alias k="kubectl"
alias h="helm"
alias kc="kubectl config use-context"
alias kn="kubectl config set-context --current --namespace"

#### API keys
export OPENROUTER_API_KEY=$(security find-generic-password -a "$USER" -s "OPENROUTER_API_KEY" -w)

api() {
    echo "=== OpenRouter ==="
    curl -s https://openrouter.ai/api/v1/key \
        -H "Authorization: Bearer $(security find-generic-password -a "$USER" -s "OPENROUTER_API_KEY" -w)" \
        | jq '.data | {usage, limit, limit_remaining}'
}

#### fabric
alias q='noglob _q_ask_me'
alias q!='noglob _q_web_search'

_q_ask_me() {
    setopt local_options no_monitor
    local tmpfile=$(mktemp)
    fabric-ai --pattern q <<< "$*" > "$tmpfile" 2>/dev/null &
    local pid=$!

    local spinner='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    while kill -0 $pid 2>/dev/null; do
        printf '\r%s thinking...' "${spinner:$i:1}"
        i=$(( (i+1) % 10 ))
        sleep 0.1
    done
    printf '\r\033[K'

    cat "$tmpfile" | glow
    rm "$tmpfile"
}

_q_web_search() {
    setopt local_options no_monitor
    local tmpfile=$(mktemp)
    fabric-ai --pattern q --model openai/gpt-4o-search-preview <<< "$*" > "$tmpfile" 2>/dev/null &
    local pid=$!

    local spinner='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    while kill -0 $pid 2>/dev/null; do
        printf '\r%s searching...' "${spinner:$i:1}"
        i=$(( (i+1) % 10 ))
        sleep 0.1
    done
    printf '\r\033[K'

    cat "$tmpfile" | glow
    rm "$tmpfile"
}

#### Functions
# mkdir and then cd into it
mkcd() {
  mkdir -p -- "$1" && cd -- "$1"
}

awsp() {
  local profile
  profile=$(cat <(grep '^\[' ~/.aws/config | tr -d '[]' | sed 's/^profile //' | grep -v '^sso-session') \
                <(grep '^\[' ~/.aws/credentials | tr -d '[]') \
            | sort -u | fzf --prompt="AWS Profile: " --height=~10 --no-preview)
  if [ -n "$profile" ]; then
    export AWS_PROFILE=$profile
    echo "➜ AWS_PROFILE=$AWS_PROFILE"
    if aws sts get-caller-identity &>/dev/null; then
      echo "✓ session active"
    else
      echo "✗ session expired — logging in..."
      aws sso login
    fi
  fi
}

#### EDITOR
EDITOR=/usr/bin/vim

#### PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

#### Completions
fpath=(
  $fpath
  ~/.zsh/completions 
  /Users/nv/.docker/completions 
  /opt/homebrew/share/zsh/site-functions/
)
autoload -Uz compinit
compinit -C -i -d ~/.zcompdump

# Enable case-insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

#### Software
# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# fzf
# theme and keybinding
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:-1,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4 \
--bind=alt-k:up,alt-j:down,alt-K:preview-page-up,alt-J:preview-page-down \
--preview '[ -d {} ] && tree -aCL 1 {} || bat --color=always {}' \
--tmux \
--multi"

# ignore .git, .venv, node_modules
export FZF_DEFAULT_COMMAND="find \( \
    -name '.venv' -o \
    -name '.git' -o \
    -name 'node_modules' \
\) -prune -o -print"

# export FZF_COMPLETION_TRIGGER=','

### Lazy-load completions
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

# terraform
terraform() {
  unset -f terraform
  autoload -U +X bashcompinit && bashcompinit  # Enable bash-style completions
  complete -o nospace -C /opt/homebrew/bin/terraform terraform  # Load terraform completions
  command terraform "$@"
}

# gcloud
gcloud() {
  unset -f gcloud
  export PATH="$PATH:$(gcloud info --format='value(installation.sdk_root)')/bin"
  source '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'
  source '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'
  gcloud "$@"
}

# sdkman
sdk() {
  unset -f sdk
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk "$@"
}

# safari
safari() {
    local query=$(echo "$*" | sed 's/ /+/g')
    open -a Safari "https://www.google.com/search?q=$query"
}

