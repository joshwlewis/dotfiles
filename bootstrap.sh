#!/usr/bin/env bash

script_dir="$(
    cd "$(dirname "$0")" || exit 1
    pwd -P
)"

dotfiles=(
    .config/kitty/kitty.conf
    .config/nvim/init.lua
    .config/nvim/lazyvim.json
    .rgignore
    .aliases
    .alacritty.toml
    .asdfrc
    .bash_profile
    .bash_prompt
    .bashrc
    .curlrc
    .editorconfig
    .exports
    .functions
    .gdbinit
    .gemrc
    .gitattributes
    .gitconfig
    .gvimrc
    .hgignore
    .hushlogin
    .hyperterm.js
    .inputrc
    .irbrc
    .markdownlint-cli2.yaml
    .screenrc
    .tmux.conf
    .vimrc
    .wgetrc
    .zshrc
)

function symlinkAll() {
    for f in "${dotfiles[@]}"; do
        echo "$script_dir/$f"
        mkdir -p "~$(dirname "$f")"
        rm "$HOME/$f"
        ln -s "$script_dir/$f" "$HOME/$f"
    done
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
    symlinkAll
else
    read -pr "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        symlinkAll
    fi
fi
unset symlinkAll
