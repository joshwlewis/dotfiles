[ -n "$PS1" ] && source ~/.bash_profile

command -v starship &>/dev/null && eval "$(starship init bash)"
