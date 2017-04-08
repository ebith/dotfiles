#!/usr/bin/env zsh
dotfiles=('.bundler/config' '.config/peco/config.json' '.gemrc' '.gitconfig' '.tigrc' '.tmux.conf' '.zshenv' '.zshrc' 'bin' '.hammerspoon')

cd $(dirname $0)
for dotfile in $dotfiles; do
  target=$HOME/$dotfile
  targetDir=$(dirname $target)
  [[ -d  $targetDir ]] || mkdir -p $targetDir
  ln -Fis $PWD/$dotfile $targetDir/
done
