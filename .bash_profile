[ -f ~/.profile ] && source ~/.profile
command -v mise &>/dev/null && eval "$(mise activate bash)"
[ -f ~/.bashrc ] && source ~/.bashrc
