
[![Build Status](https://travis-ci.org/lindig/xen-ocaml-tools.svg?branch=master)](https://travis-ci.org/lindig/xen-ocaml-tools)

# OCaml Xen Tools outside Xen

This is an experiment to explore building the [OCaml] tools that are
part of [Xen] independently using jbuilder/[dune] and [Opam]. Goals are:

* make this code more accessible for [OCaml] developers
* gain access to the [Opam] ecosystem for this code base
* simplify development
* provide two [Opam] packages: [xen.opam](xen.opam) for library bindings
  and [xenstored.opam](xenstored.opam) for the xenstore daemon.

The master branch is derived from Xen 4.8.4 plus backports for
safe-string compatibility.

## Building

The code assumes that [Xen] is installed such that header files and
libraries are available. This code currently builds on a Debian system
with these packages installed:

* libxen-dev
* libsystemd-dev
* m4
* opam (the OCaml package manager)
* dune (the OCaml build tool - it can be installed from Opam)

To actually build the code, run:

```sh
$ opam install dune
$ make
```

If you are an OCaml developer, you most likely have [Opam] already
installed and configured.

## Changes and Compromises

Some small changes were required:

* The original code used `*.inc` files for C header files and this 
  suffix is not recognised by [dune] so it was changed to `*.h`.

* For xenstored, stub C code has been moved into a library and
  directory of its own. Again, this was required to meet [dune]
  restrictions.

* The build depends on auto-generated code that is derived from header
  files and an interface definition that is only present in the [Xen]
  source tree. These files have been pre-generated. See
  [tools/import.sh](tools/import.sh) for this step.

## Todo

* Define depext for more distributions in Opam files
* Use more distros in Travis matrix
* Create branches for more recent releases

[OCaml]:      https://www.ocam.org/
[Xen]:        http://xenbits.xen.org/
[dune]:       https://github.com/ocaml/dune
[manual]:     https://jbuilder.readthedocs.io/en/latest/
[Opam]:       https://opam.ocaml.org/

<!-- vim: set et -->
