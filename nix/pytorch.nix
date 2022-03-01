{ stdenv, fetchgit, python39, cmake, gpp, ... }:

let
  python = python39.withPackages (ps: with ps; [
    typing-extensions
    pyyaml
    setuptools
  ]);
in
stdenv.mkDerivation {
  name = "pytorch";
  buildInputs = [
    cmake
    gpp
    python
  ];
  src = fetchgit {
    url = "https://github.com/pytorch/pytorch";
    rev = "a556333dfa72847892c7d5064b758d5a40668ccb";
    sha256 = "sha256-M9GSCs8donHCqFsB1hGiWVhJ7hW/enOo14K1fCOtCQA=";
  };
}
