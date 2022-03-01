{ pkgs, fetchgit, stdenv, fetchzip, ... }:
let
  hasktorch-git = fetchgit {
    url = "https://github.com/hasktorch/hasktorch";
    rev = "5f97cd3fa1647092de85e4675aebdc3da1967098";
    sha256 = "sha256-w/CLe6Z1L3Lc5qrlk6QlSt0xzs6Jp/+BSuQBAwQBR/w=";
  };

  libtorch-bin =
    let
      version = "1.9.0";
      srcs = import nix/libtorch-bin-hashes.nix version;
      unavailable = throw "libtorch is not available for this platform";
      # TODO: May want to support cuda in the future
      device = "cpu";
    in
    pkgs.libtorch-bin.overrideAttrs (oldAttrs: {
      inherit version;
      src = fetchzip srcs."${stdenv.targetPlatform.system}-${device}" or unavailable;
    });

  ghc = pkgs.haskell.packages.ghc8107.extend (self: super: rec {
    libtorch-ffi-helper =
      self.callCabal2nix "libtorch-ffi-helper" "${hasktorch-git}/libtorch-ffi-helper" { };

    libtorch-ffi =
      # Note: how do these work?
      let ffi = self.callCabal2nix "libtorch-ffi" "${hasktorch-git}/libtorch-ffi" {
        c10 = libtorch-bin;
        torch = libtorch-bin;
        torch_cpu = libtorch-bin;
      };
      in
      pkgs.haskell.lib.overrideCabal ffi (drv: {
        extraLibraries = (drv.extraLibraries or [ ]) ++ [
          "${libtorch-bin}/lib"
        ];
        configureFlags = (drv.configureFlags or [ ]) ++ [
          "--extra-include-dirs=${libtorch-bin.dev}/include/torch/csrc/api/include"
        ];
      });

    hasktorch = self.callCabal2nix "hasktorch" "${hasktorch-git}/hasktorch" { };
  });

in
ghc.callCabal2nix "homing-pigeon" ./. { }
