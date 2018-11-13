FROM ocaml/opam2:debian-testing-opam
RUN sudo apt-get update
RUN sudo apt-get install -y m4 libxen-dev libsystemd-dev
RUN opam init --disable-sandboxing
RUN opam install dune
