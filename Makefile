
README.md: README.template.md examples/readme/Main.hs
	# robust webscale enterprise ready templating system
	cat README.template.md > README.md
	echo '```haskell' >> README.md
	cat examples/readme/Main.hs >> README.md
	echo '```' >> README.md

.PHONY: proto
proto:
	which proto-lens-protoc || stack install proto-lens-protoc
	mkdir -p gen
	protoc  "--plugin=protoc-gen-haskell-protolens=$$(which proto-lens-protoc)" \
    --haskell-protolens_out=./gen \
    -I proto \
		collector.proto \
		google/api/annotations.proto \
		google/api/http.proto \
		google/protobuf/timestamp.proto

.PHONY: cabal-build
cabal-build:
	cabal v2-build

.PHONY: stack-build
stack-build:
	stack build

.PHONY: weeder
weeder:
	weeder . --build

.PHONY: format
format:
	find src -name '*.hs' -exec echo "Formatting '{}'" \; -exec ormolu --mode=inplace --ghc-opt -XBangPatterns '{}' \;
	find cli -name '*.hs' -exec echo "Formatting '{}'" \; -exec ormolu --mode=inplace --ghc-opt -XBangPatterns '{}' \;

.PHONY: watch
watch:
	ghcid

.PHONY: release
release: stack-build README.md
	stack sdist
	stack upload .

.PHONY: vim
vim:
	echo ":e lightstep-haskell.cabal\n:vsplit\n:e examples/readme/Main.hs\n:vsplit\n:term" | nvim -s -
