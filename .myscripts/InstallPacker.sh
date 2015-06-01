#! /bin/bash
cd $HOME
mkdir Builds
cd Builds
mkdir Packer
cd Packer
wget http://aur.archlinux.org/packages/pa/packer/PKGBUILD .
makepkg
echo "Please install packer from its folder in ~/Builds"
