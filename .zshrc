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

  zgen load zsh-users/zsh-syntax-highlighting

  zgen save
fi

# Prompt
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='%{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m\
%{$reset_color%}:%{$fg[magenta]%}%~\
$(git_prompt_info) \
%{$fg[red]%}%(!.#.►)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}("
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}☼%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}☂%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[cyan]%})%{$reset_color%}"
