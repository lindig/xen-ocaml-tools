# vim: set noet ts=8:
#
# This Makefile is not called from Opam but only used for 
# convenience during development
#

NAME = lindig/xen-tools

.PHONY: all clean

all:
	dune build --profile=dev

clean:
	dune clean

docker: Dockerfile
	docker build -t $(NAME) -f tools/Dockerfile



