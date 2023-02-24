{ config, pkgs, lib, ...}:
let
  ssh-ident = import ../../pkgs/ssh-ident.nix;
in {
  
  home.packages = with pkgs; [
    ssh-ident
  ];

  home.file.".ssh-ident".source = ./config.py;

  programs.zsh.shellAliases = {
    "sshuttle" = "sshuttle -e ${ssh-ident}/bin/ssh-ident"; 
  };

  programs.zsh.sessionVariables = {
    GIT_SSH_COMMAND = "ssh";
  };
}
