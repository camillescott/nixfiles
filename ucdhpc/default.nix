{ config, pkgs, lib, ...}: 
let

  username = "camw";
  homeDirectory = "/home/camw";

in {

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.packages = pkgs.callPackage ./packages.nix {};

  programs.bash.enable = true;

}
