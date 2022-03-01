{
  description = "Homing Pigeon";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    hasktorch = {
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.utils.follows = "flake-utils";
      url = "github:hasktorch/hasktorch";
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowBroken = true;
        };
        homingPigeon = pkgs.callPackage ./homing-pigeon.nix { };

      in
      {
        devShell = import ./shell.nix pkgs;
        defaultPackage = homingPigeon;
      });
}
