{ config, pkgs, lib, ... }: {

  home.packages = with pkgs; [
    obsidian
    texlive.combined.scheme-full
    igv
    wireshark
  ];

  home.sessionVariables = {
    XCURSOR_PATH = "$RUNTIME/usr/share/icons:$XCURSOR_PATH";
  };

  imports = [ ./linux ./common ./common/kitty ];

}
