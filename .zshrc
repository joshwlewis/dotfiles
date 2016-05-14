for dotfile in ~/.(path|exports|aliases|functions); do
  source $dotfile
done

source ~/.zplug.zsh

zplug "themes/dpoggi",      from:oh-my-zsh
zplug "plugins/vi-mode",    from:oh-my-zsh
zplug "plugins/bower",      from:oh-my-zsh, nice:10
zplug "plugins/bundler",    from:oh-my-zsh
zplug "plugins/git",        from:oh-my-zsh, nice:10
zplug "plugins/rbenv",      from:oh-my-zsh
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
