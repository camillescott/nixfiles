{ config, pkgs, lib, ... }:
let
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };

  # always installs latest version
  plugin = pluginGit "HEAD";
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "camille";
  home.homeDirectory = "/home/camille";

  home.packages = with pkgs; [
    bfg-repo-cleaner
    figlet
    gephi
    igv
  ];

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraConfig = builtins.concatStringsSep "\n" [
      (lib.strings.fileContents ./vim/base.vim)
    ];
    extraPackages = [
      pkgs.ccls
    ];
    plugins = with pkgs.vimPlugins; [
      coc-nvim
      coc-highlight
      (plugin "godlygeek/tabular")

      # fuzzy finding, browsing
      (plugin "vijaymarupudi/nvim-fzf")
      (plugin "kien/ctrlp.vim")
      (plugin "scrooloose/nerdtree")

      # git
      (plugin "tpope/vim-fugitive")

      # color highlight movement
      (plugin "easymotion/vim-easymotion")

      # color related
      (plugin "vim-scripts/CycleColor")
      (plugin "flazz/vim-colorschemes")
      (plugin "vim-scripts/PapayaWhip")
      (plugin "zanglg/nova.vim")
      (plugin "junegunn/goyo.vim")
      (plugin "jnurmine/Zenburn")
      (plugin "franbach/miramare")

      # documentation plugins
      (plugin "vim-scripts/DoxygenToolkit.vim")
      (plugin "alpertuna/vim-header")
      (plugin "luochen1990/rainbow")

      # highlighting support
      (plugin "sheerun/vim-polyglot")
      (plugin "coyotebush/vim-pweave")
      (plugin "ivan-krukov/vim-snakemake")
      (plugin "tshirtman/vim-cython")
      (plugin "plasticboy/vim-markdown")
      (plugin "lepture/vim-jinja")
    ];
    coc = {
      enable = true;
      settings = {
        languageserver = {
          ccls = {
            command = "ccls";
            filetypes = ["c" "cc" "cpp" "c++" "objc" "objcpp"];
            rootPatterns = [
              ".ccls"
              "compile_commands.json"
              ".git/"
              ".hg/"
            ];
            initializationOptions = {
              cache = {
                directory = "/tmp/ccls";
              };
            };
          };
        };
        "jedi.enable" = true;
        "jedi.startupMessage" = false;
        "jedi.markupKindPreferred" = "plaintext";
        "jedi.trace.server" = "off";
        "jedi.jediSettings.autoImportModules" = [];
        #"jedi.executable.command" = "/home/camille/miniconda/bin/jedi-language-server";
        "jedi.executable.args" = [];
        "jedi.completion.disableSnippets" = false;
        "jedi.completion.resolveEagerly" = false;
        "jedi.diagnostics.enable" = true;
        "jedi.diagnostics.didOpen" = true;
        "jedi.diagnostics.didChange" = true;
        "jedi.diagnostics.didSave" = true;
      };
    };
  };
  
  home.file.".condarc".source = ./conda/condarc;

  programs.htop = {
    enable = true;
    settings = {
      tree_view = true;
      show_cpu_frequency = true;
      show_cpu_usage = true;
      show_program_path = false;
    };
  };

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
