#---ZSH Settings------------------------------------------------
# vim mode
bindkey -v
bindkey "^R" history-incremental-search-backward

#---PATH--------------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

#---EDITOR------------------------------------------------------
EDITOR=/opt/homebrew/bin/nvim

#---Completions-------------------------------------------------
fpath=(
  $fpath
  ~/.zsh/completions 
  /opt/homebrew/share/zsh/site-functions/
)
autoload -Uz compinit
compinit -C -i -d ~/.zcompdump

# Enable case-insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

#---API keys----------------------------------------------------
# Load secrets from age-encrypted dotenv file
eval "$(age -d -i ~/.ssh/nv/nv ~/.env.age 2>/dev/null)"

#---Functions---------------------------------------------------
for file in /Users/nv/.zshrc.d/functions/*; do
  if [[ -f "$file" ]]; then
    source "$file"
  fi
done

#---Aliases-----------------------------------------------------
for file in /Users/nv/.zshrc.d/alias/*; do
  if [[ -f "$file" ]]; then
    source "$file"
  fi
done

#---Init Software-----------------------------------------------
for file in /Users/nv/.zshrc.d/init/*; do
  if [[ -f "$file" ]]; then
    source "$file"
  fi
done


# SignalsAI Tracker
export PATH="/Users/nv/.signals/bin:$PATH"
