#!/usr/bin/env zsh

# * ~/.locals and ~/.creds  can be used for other settings you don’t want to commit.
for dotfile in ~/.(exports|aliases|functions|locals|creds); do
  [ -f "$dotfile" ] && source "$dotfile"
done

# Enable vim keybindings
bindkey -v

# Various completions
command -v fzf &>/dev/null && source <(fzf --zsh)

# Setup starship prompt
command -v starship &>/dev/null && eval "$(starship init zsh)"
