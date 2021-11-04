{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "camille";
  home.homeDirectory = "/home/camille";

  home.packages = with pkgs; [
    figlet
  ];

  programs.vim.enable = true;
  home.file.".vimrc".source = ./vimrc;

  programs.htop.enable = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    history.expireDuplicatesFirst = true;
    history.extended = true;
    history.save = 10000000;
    history.size = 10000000;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git-extras"
        "git"
        "gitfast"
        "github"
        "pip"
        "ssh-agent"
        "colorize"
        "colored-man-pages"
        "catimg"
      ];
      extraConfig = ''
        zstyle :omz:plugins:ssh-agent agent-forwarding on
      '';
      custom = "$HOME/nixfiles/oh-my-zsh";
      theme = "camillescott";
    };
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "932e29a0c75411cb618f02995b66c0a4a25699bc";
          hash = "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
        };
      }
    ];
    sessionVariables = {
      EDITOR = "vim";
      GCC_COLORS = "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";
      VIRTUAL_ENV_DISABLE_PROMPT = 1;
      ZSH_THEME_CONDA_ENV_PROMPT_PREFIX = "‹";
      ZSH_THEME_CONDA_ENV_PROMPT_SUFFIX = "› ";
      ZSH_THEME_PY_PROMPT_PREFIX = "⟮py";
      ZSH_THEME_PY_PROMPT_SUFFIX = "⟯ ";

    };
    shellAliases = {
      ".." = "cd ..";

    };
    initExtraFirst = ''
      source $HOME/nixfiles/functions.zsh
    '';
    initExtra = ''
    __conda_setup="$('$HOME/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/miniconda/etc/profile.d/conda.sh" ]; then
            . "$HOME/miniconda/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/miniconda/bin:$PATH"
        fi
    fi
    unset __conda_setup
    '';
  };

  programs.git = {
    enable = true;
    userName = "Camille Scott";
    userEmail = "camille.scott.w@gmail.com";
    aliases = {
      graph = "log --oneline --abbrev-commit --all --graph --decorate --color";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
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
