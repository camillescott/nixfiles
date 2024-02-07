{ config, pkgs, lib, ...}: 
let

  username = "camw";
  homeDirectory = "/home/camw";

in {

  home.username = username;
  home.homeDirectory = homeDirectory;
  home.packages = with pkgs; [
    tmux
  ];

  imports = [ ./common ];

  programs.bash = {
    enable = true;
    profileExtra = "export XDG_DATA_DIRS=\"$HOME/.nix-profile/share:$XDG_DATA_DIRS\"";
  };

  programs.zsh = {
    initExtraFirst = ''
      export TERM=xterm-256color
      export PATH=$HOME/.nix-profile/bin:$PATH
      export LANG=C.UTF-8
      ${homeDirectory}/.local/bin/nix shell nixpkgs#nix nixpkgs#zsh --command zsh

    '';
  };
}
