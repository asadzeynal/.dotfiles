#!/usr/bin/env bash

DOTFILES="$HOME/.dotfiles"
STOW_FOLDERS="nvim"

pushd "$DOTFILES" || exit

IFS=',' read -r -a folders <<< "$STOW_FOLDERS"

for folder in "${folders[@]}"; do
    echo "Stowing $folder..."
    stow -D "$folder"
    stow "$folder"
done

popd
