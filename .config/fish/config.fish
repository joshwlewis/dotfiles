# Load the solarized fish colors
. $HOME/.config/fish/solarized.fish

# Setup rbenv
set -gx RBENV_ROOT /usr/local/var/rbenv
. (rbenv init -|psub)

# Set default editor to mvim terminal
set -x EDITOR 'mvim -v'
