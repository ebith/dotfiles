#!/bin/sh
cd $(dirname $0)
for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitignore' ] && [ $dotfile != '.gitmodules' ]
    then
        ln -Fis "$PWD/$dotfile" $HOME
    fi
done
