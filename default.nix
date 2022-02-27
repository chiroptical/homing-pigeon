{ pkgs ? import <nixpkgs> { } }:

pkgs.callPackage ./nix/pytorch.nix { }
