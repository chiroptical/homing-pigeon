{
  description = "homing-pigeon";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowBroken = true;
      };
      homing-pigeon = pkgs.callPackage ./homing-pigeon.nix {};
    in {
      devShell = import ./shell.nix {
        inherit pkgs;
      };
      defaultPackage = homing-pigeon;
      packages = flake-utils.lib.flattenTree {
        inherit homing-pigeon;
      };
    });
}
