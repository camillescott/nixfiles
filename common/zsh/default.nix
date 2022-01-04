{ config, pkgs, lib, ... }: {

  programs.zsh = {
    enable = true;
    autocd = false;
    enableAutosuggestions = false;
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
      custom = "$HOME/nixfiles/common/oh-my-zsh";
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
      source $HOME/nixfiles/common/zsh/functions.zsh
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
}
