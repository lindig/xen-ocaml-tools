# vim: set noet ts=8:
#
# This Makefile is not called from Opam but only used for 
# convenience during development
#

NAME = lindig/xen-tools

.PHONY: all clean

all:
	jbuilder build

clean:
	jbuilder clean

docker: Dockerfile
	docker build -t $(NAME) .

inside: docker
	sh travis.sh
