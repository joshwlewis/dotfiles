export ZSH=/Users/jlewis/.oh-my-zsh

ZSH_THEME="afowler"

for dotfile in ~/.(path|exports|aliases|functions); do
  source $dotfile
done

plugins=(git rbenv bundler)

source $ZSH/oh-my-zsh.sh

# Source fzf completions and hotkeys if it's installed
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
