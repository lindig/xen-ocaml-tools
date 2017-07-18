
[![Build Status](https://travis-ci.org/lindig/xen-ocaml-tools.svg?branch=master)](https://travis-ci.org/lindig/xen-ocaml-tools)

# OCaml Xen Tools - Work in Progress

This is the OCaml code that is part of the [Xen] hypervisor but ported
to the [jbuilder] build system -- see also its [manual]). The goal is to
package this code as a collection of [Opam] packages to make it more
accessible for OCaml developers. This is work in progress.

## Building

This code currently builds on a Debian system with these packages
installed:

* libxen-dev
* libsystemd-dev
* opam
* m4

To actually build the code, run:

```
$ opam init
$ eval `opam config env`
$ opam install jbuilder
$ jbuilder build
```

If you are an OCaml developer, you most likely have [Opam] already
installed and configured.

## Building with Docker

A Dockerfile exists mainly for running continuous integration on Travis
but it can be used to compile the project also locally. This setup does
not use Opam for installing jbuilder but clones and builds it locally
first.

```
$ docker build -t xen/ocaml .
$ ./travis.sh
```

## Changes

Some small changes were required:

* The original code used `*.inc` files for C header files and this 
  suffix is not recognised by [jbuilder] so it was changed to `*.h`.

* For oxenstored, stub C code has been moved into a library and
  directory of its own. Again, this was required to meet [jbuilder]
  restrictions.

## Todo

* Write Opam files
* Hook up code generation - a small part of the code is auto-generated


[OCaml]:      https://www.ocam.org/
[Xen]:        http://xenbits.xen.org/
[jbuilder]:   https://github.com/janestreet/jbuilder
[manual]:     https://jbuilder.readthedocs.io/en/latest/
[Opam]:       https://opam.ocaml.org/


