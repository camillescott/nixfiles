{ pkgs }:
with pkgs; let pkgsNixGL = import <nixgl> {}; in [
  pkgsNixGL.auto.nixGLDefault
]

