
README.md: README.template.md examples/readme/Main.hs
	# robust webscale enterprise ready templating system
	cat README.template.md > README.md
	echo '```haskell' >> README.md
	cat examples/readme/Main.hs >> README.md
	echo '```' >> README.md

.PHONY: proto
proto:
	which proto-lens-protoc || cabal install proto-lens-protoc
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
	cabal build

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
release: cabal-build README.md
	cabal sdist
	cabal upload .

.PHONY: vim
vim:
	echo ":e lightstep-haskell.cabal\n:vsplit\n:e examples/readme/Main.hs\n:vsplit\n:term" | nvim -s -

.PHONY: stress
stress:
	env GHCRTS="-T -s" cabal run lightstep-haskell-stress-test

.PHONY: alligator-stress
alligator-stress:
	env GHCRTS="-T -s --nonmoving-gc" cabal run lightstep-haskell-stress-test

.PHONY: profiled-stress
profiled-stress:
	# TODO(divanov): remember out how to cabal build with profiling
	# cabal install --enable-executable-profiling .
	env GHCRTS="-T -s -P" lightstep-haskell-stress-test
	stackcollapse-ghc lightstep-haskell-stress-test.prof | flamegraph.pl > p.svg
	stackcollapse-ghc lightstep-haskell-stress-test.prof | flamegraph.pl --reverse > pr.svg
	stackcollapse-ghc --alloc lightstep-haskell-stress-test.prof | flamegraph.pl > a.svg
	stackcollapse-ghc --alloc lightstep-haskell-stress-test.prof | flamegraph.pl --reverse > ar.svg

