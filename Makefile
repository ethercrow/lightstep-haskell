
README.md: README.template.md cli/Main.hs
	# robust webscale enterprise ready templating system
	cat README.template.md > README.md
	echo '```haskell' >> README.md
	cat cli/Main.hs >> README.md
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
	cabal new-build

.PHONY: stack-build
stack-build:
	stack build

.PHONY: weeder
weeder:
	weeder . --build

.PHONY: format
format:
	find src -name '*.hs' -exec echo "Formatting '{}'" \; -exec ormolu --mode=inplace '{}' \;
	find cli -name '*.hs' -exec echo "Formatting '{}'" \; -exec ormolu --mode=inplace '{}' \;

.PHONY: watch
watch:
	ghcid

.PHONY: release
release: stack-build README.md
	stack sdist
	stack upload .

.PHONY: vim
vim:
	echo ":e package.yaml\n:vsplit\n:e cli/Main.hs\n:vsplit\n:Ghcid\n:term" | nvim -s -
