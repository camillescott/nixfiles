#!/usr/bin/zsh
nix build --impure .#homeConfigurations.camw.activationPackage
./result/bin/home-manager-generation
