
.PHONY: test
test:
	nix flake check

.PHONY: update
update:
	cd ./npm && \
		rm ./*.nix && \
	node2nix --input ./deps.json

.PHONY: upgrade
upgrade: update
	@# alias helper for 'update'
	@true
