#!/bin/bash

mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
mkdir -p ~/.local/bin
curl -o ~/.local/bin/nix -L https://hydra.nixos.org/job/nix/master/buildStatic.x86_64-linux/latest/download/2/nix
chmod +x ~/.local/bin/nix
export PATH=~/.local/bin:$PATH

./rebuild.sh

cat <<EOF > $HOME/.zshrc
# Boostrap nix-managed zsh
export TERM=xterm-256color
export PATH=$HOME/.nix-profile/bin:$PATH
export LANG=C.UTF-8
$HOME/.local/bin/nix shell nixpkgs#nix nixpkgs#zsh --command zsh
EOF
