{ pkgs }:
with pkgs; let 
  pkgsNixGL = import <nixgl> {};
  tmpNixGL = pkgsNixGL.auto.nixGLDefault.overrideAttrs {
    src = pkgs.fetchFromGitHub {
      owner = "tom-ainc";
      repo = "nixGL";
      rev = "a662aa32d0991aff5e8b7ef0905d0dc2d9da5eef";
      hash = "sha256-rk8El7Sgnw4AY1uGReO0hNzXY0jA/3FhpseeGLLGmIo=";
    };
  };
in [
  #tmpNixGL
  #pkgsNixGL.auto.nixGLDefault
]

