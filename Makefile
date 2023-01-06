hpack:
	hpack .

build: hpack
	cabal build

test: hpack
	cabal test

run: hpack
	cabal run

format-haskell:
	find app/ src/ test/ -name "*.hs" -exec fourmolu -i {} +

format-nix:
	alejandra .

format: format-nix format-haskell

.PHONY: hpack build test run format-haskell format-nix format
