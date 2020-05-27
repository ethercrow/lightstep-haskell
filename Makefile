
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

deps.png: lightstep-haskell.cabal stack.yaml
	stack dot lightstep-haskell \
		--external \
		--no-include-base \
		--prune base,lens,array,bytestring,containers,deepseq,directory,filepath,mtl,parsec,pretty,process,stm,template-haskell,text,time,transformers,unix \
		| dot -Tpng -o $@

deps-tree.txt: lightstep-haskell.cabal stack.yaml
	stack ls dependencies tree lightstep-haskell \
		--no-include-base \
		--prune base,lens,array,bytestring,containers,deepseq,directory,filepath,ghc-prim,mtl,parsec,pretty,process,rts,stm,template-haskell,text,time,transformers,unix,http2,http2-grpc-proto-lens,http2-grpc-types,http2-client-grpc,http2-client,proto-lens-runtime,proto-lens-setup,proto-lens,proto-lens-protobuf-types \
    | tee $@

.PHONY: stress
stress: stack-build
	env GHCRTS="-T -s" stack exec lightstep-haskell-stress-test

.PHONY: profiled-stress
profiled-stress:
	stack install --profile
	env GHCRTS="-T -s -p" lightstep-haskell-stress-test
