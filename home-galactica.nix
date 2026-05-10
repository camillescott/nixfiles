{ config, pkgs, lib, ... }: {

  home.packages = with pkgs; [
    texlive.combined.scheme-full
    igv
    wireshark
  ];

  imports = [ ./linux ./common ./common/kitty ];

  targets.genericLinux.gpu.nvidia = {
    enable = true;
    version = "595.71.05";
    sha256 = "sha256-NiA7iWC35JyKQva6H1hjzeNKBek9KyS3mK8G3YRva4I=";
  };

}
