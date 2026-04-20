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


PROMPT='%F{blue}%~%f$(git_prompt_info) %(?.%F{black}.%F{red})\$%f '
PROMPT2='%F{red}\ %f'
RPS1='%(?..%F{red}%?%f)'

ZSH_THEME_GIT_PROMPT_PREFIX="@%F{green}"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{cyan}✓%f"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{magenta}✘%f"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v tmux &>/dev/null; then
    if [ -z "$TMUX" ] && [ ${UID} != 0 ] && [[ -o interactive ]] && ( [ ${TERM_PROGRAM} != "zed" ] || [ -n "$ZED_TERM" ] ); then
        session_name=$(shuf -n 1 /usr/share/dict/words)
        exec tmux new-session -As "${session_name}"
    fi
fi
