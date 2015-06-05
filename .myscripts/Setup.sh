#! /bin/bash

echo "Installing vundle"
~/.myscripts/InstallVundle.sh

echo "Creating undodir for Vim"
cd $HOME
mkdir .vim
cd .vim
mkdir undodir
cd $HOME

echo "Installing packer"
~/.myscripts/InstallPacker.sh

echo "Configuring Git (Saksham Sharma)"
~/.myscripts/gitconfig.sh
