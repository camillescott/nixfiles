{ config, pkgs, lib, ... }:
let

  username = "camille";
  homeDirectory = "/Users/camille";
  platPkgs = pkgs.callPackage ./packages.nix {};

in  {

  home.username = username;
  home.homeDirectory = homeDirectory;
  home.packages = platPkgs;

  imports = [ ./copyApplications.nix ];

  targets.darwin  = {
    search = "Google";
  };
}
