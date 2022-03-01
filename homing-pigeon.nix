{ pkgs, ... }:
let
  hasktorch-git = pkgs.callPackage ./nix/hasktorch-git.nix {};

  libtorch-bin = pkgs.callPackage ./nix/libtorch-bin.nix {};

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
