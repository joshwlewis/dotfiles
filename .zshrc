for dotfile in ~/.(path|exports|aliases|functions); do
  source $dotfile
done

# Enable vim-mode
bindkey -v

source ~/.zplug.zsh

zplug "themes/dpoggi",      from:oh-my-zsh
zplug "plugins/bundler",    from:oh-my-zsh
zplug "plugins/git",        from:oh-my-zsh
zplug "plugins/ruby",       from:oh-my-zsh
zplug "plugins/rbenv",      from:oh-my-zsh

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
