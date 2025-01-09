#!/usr/bin/env bash

script_dir="$(
    cd "$(dirname "$0")"
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
    .screenrc
    .tmux.conf
    .vimrc
    .wgetrc
    .zshrc
)

function symlinkAll() {
    for f in "${dotfiles[@]}"; do
        echo $script_dir/$f
        mkdir -p "~$(dirname "$f")"
        rm ~/$f
        ln -s $script_dir/$f ~/$f
    done
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    symlinkAll
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        symlinkAll
    fi
fi
unset symlinkAll
