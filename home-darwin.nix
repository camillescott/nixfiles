{ config, pkgs, lib, ... }:
let

  username = "camille";
  homeDirectory = "/Users/camille";
  platPkgs = pkgs.callPackage ./darwin/packages.nix {};

in  {

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.packages = platPkgs;

  imports = [ ./common ./common/kitty ./darwin/copyApplications.nix ];

  targets.darwin  = {
    search = "Google";
  };
}
