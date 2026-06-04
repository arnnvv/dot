HISTFILE="$HOME/.zsh_history"
DISABLE_AUTO_TITLE="true"
HISTSIZE=5000
SAVEHIST=2000
setopt hist_save_no_dups appendhistory hist_find_no_dups inc_append_history hist_ignore_all_dups
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
PROMPT='%F{#87CEEB}%2~%f '
path=(
  "/opt/homebrew/sbin"
  "$HOME/nvim-macos-arm64/bin"
  "$HOME/.local/bin"
  "/opt/homebrew/opt/postgresql@18/bin"
  "$HOME/.bun/bin"
  $path
)
typeset -U path
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
[[ -f "$HOME/.aliases.sh" ]] && source "$HOME/.aliases.sh"
autoload -Uz compinit
if [[ ! -f ~/.zcompdump.zwc ]]; then
  compinit
  zcompile ~/.zcompdump
else
  compinit -C
fi
