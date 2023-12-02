#!/usr/bin/env bash
set -e

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Requires GNU utils.
    CP=gcp
    FIND=gfind
    REALPATH=grealpath
    if [[ ! -x $(command -v $CP) || ! -x $(command -v $FIND) ]]; then
      echo "Requires $CP and $FIND."
      echo "Please install with: brew install coreutils findutils"
      exit 1
    fi
else
    CP=cp
    FIND=find
    REALPATH=realpath
fi

dotfiles=$(dirname $($REALPATH --relative-to=$HOME $(pwd)/$0))

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
# Glob matches all files with a dot in front (excluding . d ..)
"$FIND" $HOME/$dotfiles -mindepth 1 -maxdepth 1 -not '(' -name '.git' -o -name 'install.sh' ')' -exec "$CP" -Rfvs "{}" . ';'

echo "done."

echo
echo "For fish colors, open fish and type:"
echo ". ~/.config/fish/set_colors.fish"

if [ ! -d ~/.zsh/zsh-snap ]; then
  mkdir -p ~/.zsh
  git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.zsh/zsh-snap
fi

mkdir -p ~/.vim/{backup,tmp}
