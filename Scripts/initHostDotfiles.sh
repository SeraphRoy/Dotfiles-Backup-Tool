#!/usr/bin/env bash

dotfilesrc=~/.dotfilesrc
vimrc=~/.vimrc
tmuxconf=/.tmux.conf
screenrc=~/.screenrc
zshrc=~/.zshrc

if [ ! -f $dotfilesrc ]; then
   echo "[dotfiles]" >> $dotfilesrc
   echo "repository = ~/Dropbox/Dotfiles" >> $dotfilesrc
   echo "ignore = [" >> $dotfilesrc
   echo "   '.git'," >> $dotfilesrc
   echo "   '.gitignore'," >> $dotfilesrc
   echo "   '*.swp']" >> $dotfilesrc
fi

sudo pip install --upgrade dotfiles
for entry in $dotfilesrc $vimrc $tmuxconf $screenrc $zshrc; do
   dotfiles -a $entry
done
