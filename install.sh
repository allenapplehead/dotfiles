#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_tmux() {
  echo "Installing tmux..."
  cp "$DOTFILES_DIR/tmux/.tmux.conf" ~/
  echo "  ✓ ~/.tmux.conf"
}

install_zsh() {
  echo "Installing zsh..."
  cp "$DOTFILES_DIR/zsh/.zshrc" ~/
  echo "  ✓ ~/.zshrc"
}

install_ghostty() {
  echo "Installing ghostty..."
  mkdir -p ~/.config/ghostty
  cp "$DOTFILES_DIR/ghostty/config" ~/.config/ghostty/config
  echo "  ✓ ~/.config/ghostty/config"
}

install_aerospace() {
  echo "Installing aerospace..."
  cp "$DOTFILES_DIR/aerospace/.aerospace.toml" ~/
  echo "  ✓ ~/.aerospace.toml"
  mkdir -p ~/.local/bin
  cp "$DOTFILES_DIR/aerospace/release-secure-input" ~/.local/bin/
  chmod +x ~/.local/bin/release-secure-input
  echo "  ✓ ~/.local/bin/release-secure-input"
}

usage() {
  echo "Usage: $0 [dotfile...]"
  echo ""
  echo "Available dotfiles:"
  echo "  tmux      - tmux configuration (~/.tmux.conf)"
  echo "  zsh       - zsh configuration (~/.zshrc)"
  echo "  ghostty   - ghostty configuration (~/.config/ghostty/config)"
  echo "  aerospace - aerospace configuration (~/.aerospace.toml)"
  echo ""
  echo "If no arguments are given, all dotfiles are installed."
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  usage
  exit 0
fi

if [[ $# -eq 0 ]]; then
  install_tmux
  install_zsh
  install_ghostty
  install_aerospace
  echo "Done! All dotfiles installed."
  exit 0
fi

for arg in "$@"; do
  case "$arg" in
    tmux)    install_tmux ;;
    zsh)     install_zsh ;;
    ghostty) install_ghostty ;;
    aerospace) install_aerospace ;;
    *)
      echo "Unknown dotfile: '$arg'"
      echo "Run '$0 --help' to see available options."
      exit 1
      ;;
  esac
done

echo "Done!"
