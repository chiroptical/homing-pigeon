{ pkgs, fetchgit, ... }:
let
  hasktorch-git = fetchgit {
    url = "https://github.com/hasktorch/hasktorch";
    rev = "5f97cd3fa1647092de85e4675aebdc3da1967098";
    sha256 = "sha256-w/CLe6Z1L3Lc5qrlk6QlSt0xzs6Jp/+BSuQBAwQBR/w=";
  };

  ghc = pkgs.haskell.packages.ghc8107.extend (self: super: rec {
    libtorch-ffi-helper =
      self.callCabal2nix "libtorch-ffi-helper" "${hasktorch-git}/libtorch-ffi-helper" { };

    libtorch-ffi =
      let ffi = self.callCabal2nix "libtorch-ffi" "${hasktorch-git}/libtorch-ffi" {
        c10 = pkgs.libtorch-bin;
        torch = pkgs.libtorch-bin;
        torch_cpu = pkgs.libtorch-bin;
      };
      in
      pkgs.haskell.lib.overrideCabal ffi (drv: {
        extraLibraries = (drv.extraLibraries or [ ]) ++ [
          "${pkgs.libtorch-bin}/lib"
        ];
        configureFlags = (drv.configureFlags or [ ]) ++ [
          "--extra-include-dirs=${pkgs.libtorch-bin.dev}/include/torch/csrc/api/include"
        ];
      });

    # hasktorch = self.callCabal2nix "hasktorch" "${hasktorch-git}" { };
  });

in
ghc.callCabal2nix "homing-pigeon" ./. { }
