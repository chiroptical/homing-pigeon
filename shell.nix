{ pkgs, ... }:

pkgs.mkShell {
  inputsFrom = [
    (import ./homing-pigeon.nix pkgs).env
  ];
  buildInputs = with pkgs; [
    haskellPackages.cabal-install
    haskellPackages.ghcid
    haskellPackages.hlint
    haskellPackages.hpack
    haskellPackages.retrie
    haskellPackages.fourmolu
    alejandra
  ];
  withHoogle = true;
  # required for 'make test' hedgehog output
  LANG = "en_US.utf8";
}
