# Load the shell dotfiles, and then some:
# * ~/.locals and ~/.creds  can be used for other settings you don’t want to commit.
for file in ~/.{path,exports,aliases,functions,locals,creds}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2>/dev/null
done

# Enable tab completion for `g` by marking it as an alias for `git`
type _git &>/dev/null && complete -o default -o nospace -F _git g

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

# Also try to grab any brew-installed tab compltions
[ -x "$(command -v brew)" ] && [ -f $(brew --prefix)/etc/bash_completion ] && source $(brew --prefix)/etc/bash_completion

command -v fzf &>/dev/null && eval "$(fzf --bash)"
command -v mise &>/dev/null && eval "$(mise activate bash)"
