{ pkgs, ... }:
let
  myHaskell = pkgs.callPackage ./nix/myHaskell.nix { };
in
myHaskell.callCabal2nix "homing-pigeon" ./. { }
