#
# generate files from idl 
#

GEN = genwrap.py idl.py libxl_types.idl

GENERATED_FILES += xenlight.ml
GENERATED_FILES += xenlight.mli

all: $(GENERATED_FILES)

clean:
	rm -f $(GENERATED_FILES)
	rm -f _libxl_types*

xenlight.ml: xenlight.ml.in _libxl_types.ml.in
	sed -e '/^(\* @@LIBXL_TYPES@@ \*)$$/r_libxl_types.ml.in' < $< > $@

xenlight.mli: xenlight.mli.in _libxl_types.mli.in
	sed -e '/^(\* @@LIBXL_TYPES@@ \*)$$/r_libxl_types.mli.in' < $< > $@

_libxl_types.ml.in _libxl_types.mli.in _libxl_types.inc: $(GEN)
	python ./genwrap.py \
	  libxl_types.idl \
	  _libxl_types.mli.in \
	  _libxl_types.ml.in \
	  _libxl_types.h


