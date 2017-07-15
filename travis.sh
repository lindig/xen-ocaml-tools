#! /bin/bash
#

set -ex

get()
{
  wget "https://raw.githubusercontent.com/ocaml/ocaml-ci-scripts/master/$1"
}

get .travis-ocaml.sh
.   .travis-ocaml.sh

opam install -y jbuilder
jbuilder build

