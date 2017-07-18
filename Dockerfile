#

FROM ocaml/ocaml:debian-9

RUN apt-get install -y m4 libxen-dev libxen-dev libsystemd-dev
