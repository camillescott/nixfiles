{ config, pkgs, lib, ... }:
let
  # convenenience: installs a vim plugin from git with a given tag / branch
  plugin = {ref ? "HEAD", repo, postFixup ? ""}: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = baseNameOf ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
    postFixup = postFixup;
  };

  pluginFromRev = {repo, rev, ref ? "HEAD", postFixup ? ""}: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = rev;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      rev = rev;
      ref = ref;
    };
    postFixup = postFixup;
  };

in {

  programs.neovim = {
    enable = true;
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
        config = "let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-jedi', 'coc-pyright', 'coc-yaml', 'coc-cmake', 'coc-r-lsp', 'coc-snippets', 'coc-tsserver']";
      }
      #coc-cmake
      coc-fzf
      coc-highlight
      #coc-json
      #coc-pyright
      #coc-yaml
      vim-devicons
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))

      (plugin {repo = "godlygeek/tabular";})

      # fuzzy finding, browsing
      (plugin {repo = "junegunn/fzf";})
      (plugin {repo = "junegunn/fzf.vim";})
      (plugin {repo = "vijaymarupudi/nvim-fzf";})
      (plugin {repo = "ctrlpvim/ctrlp.vim";})
      (plugin {repo = "scrooloose/nerdtree";})
      (plugin {repo = "liuchengxu/vista.vim";})

      # git
      (plugin {repo = "tpope/vim-fugitive";})
      (plugin {repo = "airblade/vim-gitgutter";})

      (plugin {repo = "itchyny/lightline.vim";})

      # color {repo = highlight movement
      (plugin {repo = "easymotion/vim-easymotion";})

      # color {repo = related
      (plugin {repo = "vim-scripts/CycleColor";})
      (plugin {repo = "flazz/vim-colorschemes";})
      #(plugin {repo = "vim-scripts/PapayaWhip";})
      #(plugin {repo = "zanglg/nova.vim";})
      #(plugin {repo = "junegunn/goyo.vim";})
      (plugin {repo = "jnurmine/Zenburn";})
      (plugin {repo = "franbach/miramare";})
      (plugin {repo = "b4skyx/serenade";})
      (plugin {repo = "arcticicestudio/nord-vim";})
      (pluginFromRev {
         rev = "d83145614e8082b24a001643f1c6c00c0ea9aaef";
         ref = "main";
         repo = "EdenEast/nightfox.nvim";
       }
      )

      #
      # documentation plugins
      # 
      # single-item tarballs are currently broken: https://github.com/NixOS/nix/issues/10983
      (let
        doge-ref = "v4.7.0";
        doge-release = fetchTarball {
          url = "https://github.com/kkoomen/vim-doge/releases/download/${doge-ref}/vim-doge-helper-linux-x86_64.tar.gz";
        };
       in
       plugin {ref = "refs/tags/${doge-ref}";
               repo = "kkoomen/vim-doge";
               # fetchTarBall removes the top-level directory from the archive, but
               # the doge releases don't have one -- so, the binary itself ends up being
               # saved to a file at doge-release. So, we copy that file directly.
               postFixup = ''
                 mkdir -p $out/bin
                 cp ${doge-release}/vim-doge-helper $out/bin/vim-doge-helper
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
      (plugin {repo = "rodjek/vim-puppet";})
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
        "jedi.enable" = true;
        "jedi.hover.enable" = true;
        "r.lsp.path" = "/usr/bin/R";
        "r.lsp.debug" = true;
        "pyright.inlayHints.parameterTypes" = false;
        "pyright.inlayHints.variableTypes" = false;
      };
    };
  };

  xdg.configFile."nvim/colors/camillionaire.vim" = {
    source = ./camillionaire.vim;
  };
}
