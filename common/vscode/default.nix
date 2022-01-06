{ config, pkgs, lib, ... }: {

  programs.vscode = {
    enable = true;
    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
    extensions = with pkgs.vscode-extensions; [
      mechatroner.rainbow-csv
      pkief.material-icon-theme
      ms-azuretools.vscode-docker
      kamikillerto.vscode-colorize
      github.vscode-pull-request-github
      james-yu.latex-workshop
      ms-vscode.cpptools
      ms-toolsai.jupyter
      ms-python.vscode-pylance
      ms-python.python
    ];
  };
}
