#!/usr/bin/env zsh
for dotfile in ~/.(path|exports|aliases|functions|locals|creds); do
  source "$dotfile"
done

# Various completions
source <(fzf --zsh)
eval "$(mise activate zsh)"

# Start tmux by default when conditions are right.
if command -v tmux &>/dev/null; then
    if [ -z "$TMUX" ] && [ ${UID} != 0 ] && [[ -o interactive ]] && ( [ ${TERM_PROGRAM} != "zed" ] || [ -n "$ZED_TERM" ] ); then
        session_name=$(shuf -n 1 /usr/share/dict/words)
        exec tmux new-session -As "${session_name}"
    fi
fi
