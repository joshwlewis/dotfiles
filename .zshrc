for dotfile in ~/.(path|exports|aliases|functions); do
  source $dotfile
done

source ~/.zgen.zsh
if ! zgen saved; then
  zgen oh-my-zsh

  zgen oh-my-zsh plugins/bundler
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/rbenv
  zgen oh-my-zsh plugins/tmux
  zgen oh-my-zsh plugins/vi-mode

  zgen oh-my-zsh themes/dpoggi

  zgen load zsh-users/zsh-syntax-highlighting

  zgen save
fi
