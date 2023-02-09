{ config, pkgs, lib, ...}: {

  imports = [ ./vim ./zsh ./ssh-ident ];

  home.packages = pkgs.callPackage ./packages.nix {};
  home.file.".condarc".source = ./conda/condarc;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.htop = {
    enable = true;
    settings = {
      tree_view = false;
      show_cpu_frequency = true;
      show_cpu_usage = true;
      show_program_path = false;
      highlight_base_name = 1;
      highlight_megabytes = 1;
      highlight_threads = 1;
      fields = with config.lib.htop.fields; [
        PID
        USER
        M_SIZE
        M_RESIDENT
        M_SHARE
        STATE
        PERCENT_CPU
        PERCENT_MEM
        TIME
        COMM
      ];
    };
  };

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Camille Scott";
    userEmail = "camille.scott.w@gmail.com";
    aliases = {
      graph = "log --oneline --abbrev-commit --all --graph --decorate --color";
    };
    extraConfig = {
      pull = {
        rebase = false;
      };
      init = {
        defaultBranch = "main";
      };

      ssh = {
        variant = "ssh";
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."Code/User/settings.json" = {
    source = ./vscode/settings.json;
  };

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
