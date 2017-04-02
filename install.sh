#!/bin/bash
set -e

# Requires GNU utils. Set these to the paths you need.
# Install with: brew install coreutils findutils
CP=gcp
FIND=gfind

cd $HOME
echo "Backing up existing files to .dotfiles-backup.."
[ -d .dotfiles-backup ] || mkdir .dotfiles-backup
BACKUP_FILES=$(cd ~/.dotfiles; "$FIND" . -name '.git' -prune -o -exec test -e ~/'{}' ';' -and -exec test -f ~/'{}' ';' -and -exec test ! -L ~/'{}' ';' -print)
echo $BACKUP_FILES | xargs -n 1 echo
echo $BACKUP_FILES | xargs -I {} -n 1 sh -c 'mkdir -p ~/.dotfiles-backup/$(dirname "{}") && mv -fn {} .dotfiles-backup/{}'
echo "done."

echo
echo "Linking files in .dotfiles.."
# Glob matches all files with a dot in front (excluding . and ..)
"$FIND" "$HOME/.dotfiles" -mindepth 1 -maxdepth 1 -name '.git' -o -name 'install.sh' -o -print -exec "$CP" -Rfs {} . ';'

echo "done."

echo
echo "For fish colors, open fish and type:"
echo ". ~/.config/fish/set_colors.fish"
