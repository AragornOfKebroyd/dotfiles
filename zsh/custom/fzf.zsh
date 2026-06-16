# add keybinds to zsh for fzf
source <(fzf --zsh)

# --- fzf core ---
export FZF_DEFAULT_OPTS="
--height 60%
--layout=reverse
--border
--preview-window=right:60%
--bind 'ctrl-/:toggle-preview'
"

# Use fd for fast file search (better than find)
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

# preview with bat and Ctrl-O opens in nvim
export FZF_CTRL_T_OPTS="
--preview 'bat --style=numbers --color=always {}'
--bind 'ctrl-o:execute(nvim {})+abort'
"

# fuzzy open file in nvim
fv() {
  local file
  file=$(fd --type f --hidden --follow --exclude .git | fzf \
    --preview 'bat --style=numbers --color=always {}' \
  ) && nvim "$file"
}

# same as Alt-C
cdf() {
  local dir
  if [[ $# == 1 ]] then
  dir=$(fd --type d --hidden --follow --exclude .git . $1 | fzf \
    --preview 'ls -la {}' \
  ) && cd "$dir"

  else
  dir=$(fd --type d --hidden --follow --exclude .git | fzf \
    --preview 'ls -la {}' \
  ) && cd "$dir"

  fi

}
