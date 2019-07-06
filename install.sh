#!/bin/bash
set -e

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Requires GNU utils.
    # Install with: brew install coreutils findutils
    CP=gcp
    FIND=gfind
else
    CP=cp
    FIND=find
fi

cd $HOME
echo "Backing up existing files to dotfiles-backup.."
[ -d dotfiles-backup ] || mkdir dotfiles-backup
BACKUP_FILES=$(cd ~/.dotfiles; "$FIND" . -name '.git' -prune -o -exec test -e ~/'{}' ';' -and -exec test -f ~/'{}' ';' -and -exec test ! -L ~/'{}' ';' -print)
for f in $BACKUP_FILES; do
  echo $f
  mkdir -p ~/dotfiles-backup/$(dirname "$f") && mv -fnv ~/$f dotfiles-backup/$f
done
#echo $BACKUP_FILES | xargs -n 1 echo
#echo $BACKUP_FILES | xargs -I {} -n 1 echo sh -c 'mkdir -p ~/.dotfiles-backup/$(dirname "{}") && mv -fn {} .dotfiles-backup/{}'
echo "done."

echo
echo "Linking files in .dotfiles.."
cd "$HOME/.dotfiles"
# Glob matches all files with a dot in front (excluding . and ..)
"$FIND" . -mindepth 1 -maxdepth 1 -not '(' -name '.git' -o -name 'install.sh' ')' -print -exec "$CP" -Rfs "$HOME/.dotfiles/{}" "$HOME/" ';'

echo "done."

echo
echo "For fish colors, open fish and type:"
echo ". ~/.config/fish/set_colors.fish"
