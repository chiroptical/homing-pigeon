{ pkgs, fetchgit, ... }:
let
  hasktorch-git = fetchgit {
    url = "https://github.com/hasktorch/hasktorch";
    rev = "5f97cd3fa1647092de85e4675aebdc3da1967098";
    sha256 = "sha256-w/CLe6Z1L3Lc5qrlk6QlSt0xzs6Jp/+BSuQBAwQBR/w=";
  };

  pytorch = pkgs.python39Packages.pytorch;

  ghc = pkgs.haskell.packages.ghc8107.extend (self: super: rec {
    libtorch-ffi-helper =
      self.callCabal2nix "libtorch-ffi-helper" "${hasktorch-git}/libtorch-ffi-helper" { };

    libtorch-ffi =
      self.callCabal2nix "libtorch-ffi" "${hasktorch-git}/libtorch-ffi" {
        c10 = pytorch;
        torch = pytorch;
        torch_cpu = pytorch;
      };

    hasktorch = self.callCabal2nix "hasktorch" "${hasktorch-git}" { };
  });

in
ghc.callCabal2nix "homing-pigeon" ./. { }
