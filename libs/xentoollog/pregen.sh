#! /bin/bash

set -e

./genlevels.py _xtl_levels.mli.in _xtl_levels.ml.in _xtl_levels.h

sed -e '/^(\* @@XTL_LEVELS@@ \*)$/r_xtl_levels.ml.in' \
  xentoollog.ml.in > xentoollog.ml

sed -e '/^(\* @@XTL_LEVELS@@ \*)$/r_xtl_levels.mli.in' \
  xentoollog.mli.in > xentoollog.mli

rm -f _xtl_levels.ml.in
rm -f _xtl_levels.mli.in
