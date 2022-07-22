{ config, pkgs, lib, ... }: {

  home.packages = with pkgs; [

  ];

  imports = [ ./darwin ./common ./common/kitty ];

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
}
