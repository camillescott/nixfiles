{ config, pkgs, lib, ... }: {

  home.packages = with pkgs; [
    obsidian
    texlive.combined.scheme-full
    igv
    wireshark
  ];

  imports = [ ./linux ./common ./common/kitty ];

}
