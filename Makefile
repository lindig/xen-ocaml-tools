# vim: set noet ts=8:
#
# This Makefile is not called from Opam but only used for
# convenience during development
#

NAME = lindig/xen-tools

XEN_VERSION 	= RELEASE-4.7.6
PATCHLEVEL   	= v7.0.5

PATCHES 	= ssh://git@code.citrite.net/xs/xen.pg.git
XEN     	= https://xenbits.xen.org/git-http/xen.git

.PHONY: all clean docker

all:
	dune build --profile=dev

profile:
	dune build --profile=gprof

clean:
	dune clean

docker: tools/Dockerfile
	docker build -t $(NAME) -f tools/Dockerfile .
	docker run --rm -tv $(PWD):/mnt $(NAME) bash -c "cd /mnt; make"

import:
	test -d xen || git clone $(XEN) xen
	test -d patches || git clone $(PATCHES) patches
	git -C xen checkout $(XEN_VERSION)
	git -C patches checkout $(PATCHLEVEL)
	cd xen;	sed -e 's/#.*$$//' -e '/^ *$$/d' ../patches/master/series \
	  | while read f; do  patch -p1 < ../patches/master/$$f; done
	./tools/import.sh xen
