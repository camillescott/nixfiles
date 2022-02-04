{ config, pkgs, lib, ...}: {

  imports = [ ./vim ./zsh ];

  home.file.".condarc".source = ./conda/condarc;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.htop = {
    enable = true;
    settings = {
      tree_view = true;
      show_cpu_frequency = true;
      show_cpu_usage = true;
      show_program_path = false;
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
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.kitty = {
    enable = true;
    settings = {
      scrollback_lines           = 10000;
      enable_audio_bell          = false;
      tab_bar_style              = "separator";

      font_family                = "Operator Mono Lig Book";
      bold_font                  = "Operator Mono Lig Book";
      italic_font                = "Operator Mono Lig Book Italic";
      bold_italic_font           = "Operator Mono Lig Book Italic";
      font_size                  = 13;

      background                 = "#000000";
      foreground                 = "#c5d4d6";
      cursor                     = "#9d9eca";
      selection_background       = "#454d95";
      # black
      color0                     = "#333333";
      color8                     = "#8e8e8e";
      # red
      color1                     = "#d46b5d";
      color9                     = "#ffc4bd";
      # green
      color2                     = "#316b50";
      color10                    = "#d6fcb9";
      #yellow
      color3                     = "#b3b163";
      color11                    = "#fefdd5";
      # blue
      color4                     = "#347785";
      color12                    = "#477ab3";
      # magenta
      color5                     = "#5e468c";
      color13                    = "#ffb1fe";
      # cyan
      color6                     = "#d0d1fe";
      color14                    = "#e5e6fe";
      # white
      color7                     = "#f1f1f1";
      color15                    = "#feffff";
      selection_foreground       = "#101010";

      background_opacity         = "0.97";
      dynamic_background_opacity = true;
      dim_opacity                = "0.9";
      allow_remote_control       = true;
    };
  };

  xdg.configFile."Code/User/settings.json" = {
    source = ./vscode/settings.json;
  };

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
