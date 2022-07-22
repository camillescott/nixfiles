{ config, pkgs, lib, ... }: {

  home.packages = with pkgs; [

  ];

  imports = [ ./linux ./common ./common/kitty ];
}
