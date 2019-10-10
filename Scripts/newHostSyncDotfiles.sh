#!/usr/bin/env bash

# The script is to sync dotfiles across hosts
# Before run, makesure Dropbox is installed

case "$(uname -s)" in

   Darwin)
     #echo 'Mac OS X'
     ;;
   Linux)
     #echo 'Linux'
     ./dropbox.py start
     ;;
   CYGWIN*|MINGW32*|MSYS*)
     #echo 'MS Windows'
     ;;

   # Add here more strings to compare
   # See correspondence table at the bottom of this answer

   *)
    #echo 'other OS' 
     ;;
esac

cp -f ~/Dropbox/Dotfiles/dotfilesrc ~/.dotfilesrc
sudo pip install --upgrade dotfiles
dotfiles -s -f
vi -c "source %" ~/.vimrc +qall
vi -c "PluginInstall" +qall
echo "Sync Complete"
