{ config, pkgs, lib, ... }: {

  programs.zsh = {
    enable = true;
    autocd = false;
    enableAutosuggestions = false;
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
        "ssh-agent"
        "colorize"
        "colored-man-pages"
        "catimg"
      ];
      extraConfig = ''
        zstyle :omz:plugins:ssh-agent agent-forwarding on
      '';
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
      ZSH_THEME_CONDA_ENV_PROMPT_PREFIX = "‹";
      ZSH_THEME_CONDA_ENV_PROMPT_SUFFIX = "› ";
      ZSH_THEME_PY_PROMPT_PREFIX = "⟮py";
      ZSH_THEME_PY_PROMPT_SUFFIX = "⟯ ";
    };
    shellAliases = {
      ".." = "cd ..";
    };
    initExtraFirst = lib.strings.fileContents ./functions.zsh;
    initExtra = ''
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
  };
}
