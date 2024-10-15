{ config, pkgs, lib, ... }: {

  programs.zsh = {
    enable = true;
    autocd = false;
    autosuggestion.enable = false;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      save = 10000000;
      size = 10000000;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git-extras"
        "git"
        "gitfast"
        "github"
        "pip"
        #"ssh-agent"
        "colorize"
        "colored-man-pages"
        "catimg"
        "conda-env"
      ];
      #extraConfig = ''
      #  zstyle :omz:plugins:ssh-agent agent-forwarding on
      #'';
      custom = "${config.home.homeDirectory}/nixfiles/common/oh-my-zsh";
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
      #ZSH_THEME_CONDA_PREFIX = "%F{magenta}‹";
      #ZSH_THEME_CONDA_SUFFIX = "› %f";
      #ZSH_THEME_PY_PROMPT_PREFIX = "⟮py";
      #ZSH_THEME_PY_PROMPT_SUFFIX = "⟯ ";
    };
    shellAliases = {
      ".." = "cd ..";
      "cpufreq" = "watch -n1 \"grep '^cpu MHz' /proc/cpuinfo\"";
      "last-dmesg" = "journalctl -o short-precise -k -b -1";
    };
    initExtraFirst = lib.strings.fileContents ./functions.zsh;
  };
}
