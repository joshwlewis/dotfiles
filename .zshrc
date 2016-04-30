for dotfile in ~/.(path|exports|aliases|functions); do
  source $dotfile
done

# Enable vim-mode
bindkey -v

# vim-like history navigation
bindkey '^P' up-history
bindkey '^N' down-history

# Allow backspace after coming back from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# Kill a word at a time
bindkey '^w' backward-kill-word

# Bash-like history search
bindkey '^r' history-incremental-search-backward

source ~/.zplug.zsh

zplug "themes/dpoggi",      from:oh-my-zsh
zplug "plugins/bower",      from:oh-my-zsh, nice:10
zplug "plugins/bundler",    from:oh-my-zsh
zplug "plugins/git",        from:oh-my-zsh, nice:10
zplug "plugins/tmux",       from:oh-my-zsh, nice:10

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

# Offer to install uninstalled plugins
if ! zplug check --verbose; then
  printf "Install zplugs? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
# Then, source plugins and add commands to $PATH
zplug load
