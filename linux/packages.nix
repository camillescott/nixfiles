{ pkgs }:
with pkgs; let pkgsNixGL = import <nixgl> {}; in [
  pkgsNixGL.nixGLIntel
  texlive.combined.scheme-full
  foxitreader
]

