# vim: set noet ts=8:
#
# This Makefile is not called from Opam but only used for
# convenience during development
#

NAME = lindig/xen-tools

.PHONY: all clean docker

all:
	dune build --profile=release

build:
	dune build --profile=dev

profile:
	dune build --profile=profile

clean:
	dune clean

docker: tools/Dockerfile
	docker build -t $(NAME) -f tools/Dockerfile .
	docker run --rm -tv $(PWD):/mnt $(NAME) bash -c "cd /mnt; opam exec -- make"



