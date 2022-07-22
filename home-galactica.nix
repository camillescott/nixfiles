{ config, pkgs, lib, ... }: {

  home.packages = with pkgs; [
    texlive.combined.scheme-full
    foxitreader
    igv
  ];

  imports = [ ./linux ./common ./common/kitty ];

}
