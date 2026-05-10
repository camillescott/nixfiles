{ config, pkgs, lib, ...}: 
let

  username = "camille";
  homeDirectory = "/home/camille";
  applications = "${homeDirectory}/.nix-profile/share/applications";

in {

  imports = [ ../common/ssh-ident ];
  targets.genericLinux.enable = true;

  home.username = username;
  home.homeDirectory = homeDirectory;
  home.packages = pkgs.callPackage ./packages.nix {};

  programs.bash = {
    enable = true;
    profileExtra = "export XDG_DATA_DIRS=\"$HOME/.nix-profile/share:$XDG_DATA_DIRS\"";
  };

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

  xdg.configFile."Code/User/settings.json" = {
    source = ../common/vscode/settings.json;
  };

}
