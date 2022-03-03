build: hpack
	cabal build

hpack:
	hpack .

nix-format:
	alejandra .

format: nix-format
	find src/ app/ -name "*.hs" -exec fourmolu -o '-XTypeApplications' -o '-XImportQualifiedPost' -i {} +

run: hpack
	cabal run homing-pigeon-exe

test: hpack
	cabal test

ghcid: hpack
	ghcid -c 'cabal repl'

.PHONY: build hpack nix-format format run test ghcid
