{ config, pkgs, lib, ... }:
let
  # convenenience: installs a vim plugin from git with a given tag / branch
  plugin = {ref ? "HEAD", repo, postFixup ? ""}: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = baseNameOf ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
    postFixup = postFixup;
  };

in {

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
      (lib.strings.fileContents ./base.vim)
      (lib.strings.fileContents ./coc.vim)
      (lib.strings.fileContents ./colors.vim)
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
      (let
        doge-ref = "v3.11.0";
        doge-release = fetchTarball {
          url = "https://github.com/kkoomen/vim-doge/releases/download/${doge-ref}/vim-doge-linux.tar.gz";
          sha256 = "1ib2fq5aix9z736j8nqzjamcmbv2lsnirwipdlddaypw794lkc94";
        };
       in
       plugin {ref = "refs/tags/${doge-ref}";
               repo = "kkoomen/vim-doge";
               # fetchTarBall removes the top-level directory from the archive, but
               # the doge releases don't have one -- so, the binary itself ends up being
               # saved to a file at doge-release. So, we copy that file directly.
               postFixup = ''
                 mkdir -p $out/bin
                 cp ${doge-release} $out/bin/vim-doge
               '';}
      )
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
          reportUnusedCoroutine = "warning";
        };
        "jedi.enable" = false;
      };
    };
  };

}