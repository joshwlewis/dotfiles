#!/usr/bin/env zsh
for dotfile in ~/.(path|exports|aliases|functions|creds); do
  source "$dotfile"
done

source ~/.zgen/zgen.zsh
if ! zgen saved; then
  zgen oh-my-zsh

  zgen oh-my-zsh plugins/bundler
  zgen oh-my-zsh plugins/vi-mode

  zgen load zsh-users/zsh-syntax-highlighting

  zgen save
fi

# Prompt
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='%{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m\
%{$reset_color%}:%{$fg[magenta]%}%~\
$(git_prompt_info) \
%{$fg[reset_color]%}%(!.#.▹) '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}("
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}☼%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}☂%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[cyan]%})%{$reset_color%}"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh

if command -v tmux &>/dev/null; then
    if [ -z "$TMUX" ] && [ ${UID} != 0 ] && [[ -o interactive ]] && ( [ ${TERM_PROGRAM} != "zed" ] || [ -n "$ZED_TERM" ] ); then
        session_name=$(shuf -n 1 /usr/share/dict/words)
        exec tmux new-session -As "${session_name}"
    fi
fi
