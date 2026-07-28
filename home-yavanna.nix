{ config, pkgs, lib, ... }: {

  home.packages = with pkgs; [
    texlive.combined.scheme-full
    igv
    wireshark
  ];

  imports = [ ./linux ./common ./common/kitty ];

  targets.genericLinux.gpu.nvidia = {
    enable = true;
    version = "610.43.03";
    sha256 = "sha256-ReLUwTSiPDXlDyU6SqY+fl6NF+PRhdSgfIpY6WEu05I=";
  };

}
