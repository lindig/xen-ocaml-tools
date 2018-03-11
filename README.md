
[![Build Status](https://travis-ci.org/lindig/xen-ocaml-tools.svg?branch=master)](https://travis-ci.org/lindig/xen-ocaml-tools)

# OCaml Xen Tools outside Xen

This is an experiment to explore building the [OCaml] tools that are
part of [Xen] independently using jbuilder/[dune] and [Opam]. Goals are:

* make this code more accessible for [OCaml] developers
* gain access to the [Opam] eco system for this code base
* simplify development

The master branch is derived from [Xen
4.8.3](https://blog.xenproject.org/2018/01/24/xen-project-4-8-3-is-available/).

## Building

The code assumes that [Xen] is installed such that header files and
libraries are available. This code currently builds on a Debian system
with these packages installed:

* libxen-dev
* libsystemd-dev
* m4
* opam (the OCaml package manager)

To actually build the code, run:

```
$ make
```

If you are an OCaml developer, you most likely have [Opam] already
installed and configured.

## Building with Docker

A Dockerfile exists mainly for running continuous integration on Travis
but it can be used to compile the project also locally. 

```
$ make inside
```

## Changes and Compromises

Some small changes were required:

* The original code used `*.inc` files for C header files and this 
  suffix is not recognised by [dune] so it was changed to `*.h`.

* For xenstored, stub C code has been moved into a library and
  directory of its own. Again, this was required to meet [dune]
  restrictions.

* The build depends on auto-generated code that is derived from header
  files and an interface definition that is only present in the [Xen]
  source tree. These files have been pre-generated but the repository
  contains Makefiles and sources to re-generate them. This is the most
  version-dependent link between [Xen] and this code. 

## Todo

* Write Opam files
* Support a configure step


[OCaml]:      https://www.ocam.org/
[Xen]:        http://xenbits.xen.org/
[dune]:       https://github.com/ocaml/dune
[manual]:     https://jbuilder.readthedocs.io/en/latest/
[Opam]:       https://opam.ocaml.org/


