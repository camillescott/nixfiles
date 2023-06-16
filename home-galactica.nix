{ config, pkgs, lib, ... }: {

  home.packages = with pkgs; [
    texlive.combined.scheme-full
    igv
    wireshark
  ];

  imports = [ ./linux ./common ./common/kitty ];

}
