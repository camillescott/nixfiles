{ config, pkgs, lib, ... }:
let
  # installs a vim plugin from git with a given tag / branch
  plugin = {ref ? "HEAD", repo, postInstall ? ""}: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
    postInstall = postInstall;
  };

  # nixGL channel
  pkgsNixGL = import <nixgl> {};

  username = "camille";
  homeDirectory = "/home/camille";
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = homeDirectory;

  # General userland packages to manage
  home.packages = with pkgs; [
    bfg-repo-cleaner
    figlet
    gephi
    igv
    pkgsNixGL.nixGLIntel
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
      (lib.strings.fileContents ./vim/coc.vim)
      (lib.strings.fileContents ./vim/colors.vim)
    ];
    extraPackages = [
      pkgs.ccls
      pkgs.fzf
    ];
    plugins = with pkgs.vimPlugins; [
      { 
        plugin = coc-nvim;
        config = "let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-jedi', 'coc-pyright', 'coc-yaml', 'coc-cmake']";
      }
      #coc-cmake
      coc-fzf
      coc-highlight
      #coc-json
      #coc-pyright
      #coc-yaml

      (plugin {repo = "godlygeek/tabular";})

      # fuzzy finding, browsing
      (plugin {repo = "junegunn/fzf";})
      (plugin {repo = "junegunn/fzf.vim";})
      (plugin {repo = "vijaymarupudi/nvim-fzf";})
      (plugin {repo = "kien/ctrlp.vim";})
      (plugin {repo = "scrooloose/nerdtree";})

      # git
      (plugin {repo = "tpope/vim-fugitive";})

      # color {repo = highlight movement
      (plugin {repo = "easymotion/vim-easymotion";})

      # color {repo = related
      (plugin {repo = "vim-scripts/CycleColor";})
      (plugin {repo = "flazz/vim-colorschemes";})
      (plugin {repo = "vim-scripts/PapayaWhip";})
      (plugin {repo = "zanglg/nova.vim";})
      (plugin {repo = "junegunn/goyo.vim";})
      (plugin {repo = "jnurmine/Zenburn";})
      (plugin {repo = "franbach/miramare";})

      # documentation plugins
      #(plugin {repo = "vim-scripts/DoxygenToolkit.vim"})
      (plugin {repo = "kkoomen/vim-doge";})
      # TODO: figure out how to automate / package the postinstall call here
      #         postInstall = "nvim +\"call doge#install({headless: 1})\" +qall";})
      (plugin {repo = "alpertuna/vim-header";})
      (plugin {repo = "luochen1990/rainbow";})

      # highlighting support
      (plugin {repo = "sheerun/vim-polyglot";})
      (plugin {repo = "coyotebush/vim-pweave";})
      (plugin {repo = "ivan-krukov/vim-snakemake";})
      (plugin {repo = "tshirtman/vim-cython";})
      (plugin {repo = "plasticboy/vim-markdown";})
      (plugin {repo = "lepture/vim-jinja";})
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
        "python.analysis.diagnosticSeverityOverrides" = {
          reportOptionalMemberAccess = "warning";
        };
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

  # Build a .desktop file for kitty that launches it with nixGL
  xdg.dataFile."applications/kitty.desktop" = {
    text = ''
      [Desktop Entry]
      Version=1.0
      Type=Application
      Name=kitty
      GenericName=Terminal emulator
      Comment=A fast, feature full, GPU based terminal emulator
      TryExec=kitty
      Exec=nixGLIntel kitty
      Icon=${homeDirectory}/.nix-profile/share/icons/hicolor/256x256/apps/kitty.png
      Categories=System;TerminalEmulator;
    '';
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
