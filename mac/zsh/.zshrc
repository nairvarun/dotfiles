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
  /Users/nv/.docker/completions 
  /opt/homebrew/share/zsh/site-functions/
)
autoload -Uz compinit
compinit -C -i -d ~/.zcompdump

# Enable case-insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

#---API keys----------------------------------------------------
# security add-generic-password -a "$USER" -s "OPENROUTER_API_KEY" -w "xxxx"
export OPENROUTER_API_KEY=$(security find-generic-password -a "$USER" -s "OPENROUTER_API_KEY" -w)

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

