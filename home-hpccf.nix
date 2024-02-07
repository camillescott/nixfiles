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
}
