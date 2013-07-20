#!/bin/bash

cd $HOME
echo "Backing up existing files to .dotfiles-backup.."
mkdir .dotfiles-backup
find .dotfiles/ -mindepth 1 -maxdepth 1 -name '.git' -prune -o -printf '%f\n' | xargs -I {} mv -fn {} .dotfiles-backup/{} 2>/dev/null

echo "Linking files in .dotfiles.."
# Glob matches all files with a dot in front (excluding . and ..)
cp -Rs "$HOME/.dotfiles/".[!.]* "$HOME"
# Clean up git directory
rm -rf .git

echo "done."
