{ config, pkgs, lib, ... }: {

  home.packages = with pkgs; [

  ];

  imports = [ ./darwin ./common ./common/kitty ];

}
