build: hpack
	cabal build

hpack:
	hpack .

format:
	find src/ app/ -name "*.hs" -exec fourmolu -i {} +

run: hpack
	cabal run homing-pigeon-exe

test: hpack
	cabal test

ghcid: hpack
	ghcid -c 'cabal repl'

.PHONY: build hpack format run test ghcid
