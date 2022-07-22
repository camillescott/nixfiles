{ config, pkgs, lib, ...}: 
let

  username = "camille";
  homeDirectory = "/home/camille";
  applications = "${homeDirectory}/.nix-profile/share/applications";

in {

  home.username = username;
  home.homeDirectory = homeDirectory;
  home.packages = pkgs.callPackage ./packages.nix {};

  programs.bash.enable = true;

  # Build a .desktop file for kitty that launches it with nixGL
  xdg.dataFile."applications/kitty.desktop" = {
    text = ''
      [Desktop Entry]
      Version=1.0
      Type=Application
      Name=kitty
      GenericName=Terminal emulator
      Comment=A fast, feature full, GPU based terminal emulator
      TryExec=kitty
      Exec=nixGLIntel kitty
      Icon=${homeDirectory}/.nix-profile/share/icons/hicolor/256x256/apps/kitty.png
      Categories=System;TerminalEmulator;
    '';
  }; 
}
