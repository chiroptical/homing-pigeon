{
  pkgs,
  stdenv,
  fetchzip,
  ...
}: let
  version = "1.9.0";
  srcs = import ./libtorch-bin-hashes.nix version;
  unavailable = throw "libtorch is not available for this platform";
  # TODO: May want to support cuda in the future
  device = "cpu";
in
  pkgs.libtorch-bin.overrideAttrs (oldAttrs: {
    inherit version;
    src = fetchzip srcs."${stdenv.targetPlatform.system}-${device}" or unavailable;
  })
