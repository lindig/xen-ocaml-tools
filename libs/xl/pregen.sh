#! /bin/bash
# generate code from interface definitions

set -e

python ./genwrap.py \
	  libxl_types.idl \
	  _libxl_types.mli.in \
	  _libxl_types.ml.in \
	  _libxl_types.h

sed -e '/^(\* @@LIBXL_TYPES@@ \*)$/r_libxl_types.ml.in' \
  xenlight.ml.in > xenlight.ml

sed -e '/^(\* @@LIBXL_TYPES@@ \*)$/r_libxl_types.mli.in' \
  xenlight.mli.in > xenlight.mli

rm -f _libxl_types.mli.in
rm -f _libxl_types.ml.in


