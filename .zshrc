#!/usr/bin/env zsh
for dotfile in ~/.(path|exports|aliases|functions|locals|creds); do
  source "$dotfile"
done

# Enable vim keybindings
bindkey -v

# Various completions
command -v fzf &>/dev/null && source <(fzf --zsh)
command -v mise &>/dev/null && eval "$(mise activate zsh)"

# Setup starship prompt
command -v starship &>/dev/null && eval "$(starship init zsh)"

# Start tmux by default when conditions are right.
if command -v tmux &>/dev/null; then
    if [ -z "$TMUX" ] && [ ${UID} != 0 ] && [[ -o interactive ]] && ( [ ${TERM_PROGRAM} != "zed" ] || [ -n "$ZED_TERM" ] ); then
        session_name=$(shuf -n 1 /usr/share/dict/words)
        exec tmux new-session -As "${session_name}"
    fi
fi
