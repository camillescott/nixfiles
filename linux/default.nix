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

  programs.zsh.initExtra = ''
    __conda_setup="$('${config.home.homeDirectory}/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "${config.home.homeDirectory}/miniconda/etc/profile.d/conda.sh" ]; then
            . "${config.home.homeDirectory}/miniconda/etc/profile.d/conda.sh"
        else
            export PATH="${config.home.homeDirectory}/miniconda/bin:$PATH"
        fi
    fi
    unset __conda_setup
  '';

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
