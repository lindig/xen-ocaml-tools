# vim: set noet ts=8:
#
# This Makefile is not called from Opam but only used for 
# convenience during development
#

NAME = lindig/xen-tools

docker: Dockerfile
	docker build -t $(NAME) .
