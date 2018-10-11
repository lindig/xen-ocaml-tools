FROM ocaml/opam2:debian-9-ocaml-4.06
RUN sudo apt-get update
RUN sudo apt-get install -y m4 libxen-dev libsystemd-dev
RUN opam install dune
