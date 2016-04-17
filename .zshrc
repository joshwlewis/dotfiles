export ZSH=/Users/jlewis/.oh-my-zsh

ZSH_THEME="afowler"

for dotfile in ~/.(path|exports|aliases|functions|extra); do
  source $dotfile
done

plugins=(git rbenv bundler)

source $ZSH/oh-my-zsh.sh
