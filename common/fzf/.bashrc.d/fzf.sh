# theme and keybinding
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--bind=alt-k:up,alt-j:down,alt-K:preview-page-up,alt-J:preview-page-down \
--preview 'bat --color=always {}' \
--multi"

# ignore .git, .venv, node_modules
export FZF_DEFAULT_COMMAND="find \( \
    -name '.venv' -o \
    -name '.git' -o \
    -name 'node_modules' \
\) -prune -o -print"

export FZF_COMPLETION_TRIGGER=','