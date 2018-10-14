#!/bin/bash

echo "🛠 Installing Command Line Tools ..."
xcode-select --install

if hash brew 2>/dev/null; then
  echo "🍺 Homebrew has been installed already."
else
  echo "🍺 Installing Homebrew ..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "⏩ Updating brew formulae ..."
brew update

echo "🎛 Installing git and ansible ..."
brew install git ansible

echo "🎬 Preparing playbooks..."
install_dir="/tmp/setupmac-$RANDOM"
mkdir $install_dir
if [ "$1" = "-d" ]; then
  cp -rf ./* $install_dir
else 
  git clone https://github.com/ian-zy/setupmac.git $install_dir
fi

echo "📦 Installing applications with ansible ..."
cd $install_dir
ansible-playbook -i ./hosts setup.yml --ask-become-pass --verbose || true

echo "🗑  Cleaning up ..."
rm -Rf $install_dir

echo "Done!"
