FROM ocaml/opam:debian-9_ocaml-4.04.2
RUN sudo apt-get update
RUN sudo apt-get install -y m4 libxen-dev libxen-dev libsystemd-dev
RUN opam install jbuilder
