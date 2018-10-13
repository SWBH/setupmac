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
# TODO: check out scripts from git repo
cp -rf ./* $install_dir

echo "📦 Installing applications with ansible ..."
cd $install_dir
ansible-playbook -i ./hosts setup.yml --verbose || true

echo "🗑  Cleaning up ..."
rm -Rfv $install_dir

echo "Done!"

