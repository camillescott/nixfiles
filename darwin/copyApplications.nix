# utility to copy installed applications to the proper location for spotlight,
# from: https://github.com/reckenrode/nixos-configs/blob/main/common/darwin/home-manager/default.nix
# See also: https://github.com/nix-community/home-manager/issues/1341

{ pkgs, lib, ... }:

{
  home.activation = {
    copyApplications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      appsSrc="$newGenPath/home-path/Applications/"
      baseDir="$HOME/Applications/Home Manager Apps"
      rsyncArgs="--archive --checksum --chmod=-w --copy-unsafe-links --delete"
      $DRY_RUN_CMD mkdir -p "$baseDir"
      $DRY_RUN_CMD ${pkgs.rsync}/bin/rsync ''${VERBOSE_ARG:+-v} $rsyncArgs "$appsSrc" "$baseDir"
    '';
  };
}
