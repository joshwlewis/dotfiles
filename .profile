#!/bin/sh

case ":$PATH:" in
*":$HOME/.local/bin:"*) ;;
*) [ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH" ;;
esac

case ":$PATH:" in
*":$HOME/go/bin:"*) ;;
*) [ -d "$HOME/go/bin" ] && PATH="$HOME/go/bin:$PATH" ;;
esac

# Initialize Homebrew environment
[ -x "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"
