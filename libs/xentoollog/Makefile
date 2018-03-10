
GENERATED_FILES += xentoollog.ml 
GENERATED_FILES += xentoollog.mli 
GENERATED_FILES += _xtl_levels.h

all: $(GENERATED_FILES)

clean:
	rm -f $(GENERATED_FILES) _*.ml.in _*.mli.in

xentoollog.ml: xentoollog.ml.in _xtl_levels.ml.in
	sed -e '/^(\* @@XTL_LEVELS@@ \*)$$/r_xtl_levels.ml.in' < $< > $@

xentoollog.mli: xentoollog.mli.in _xtl_levels.mli.in
	sed -e '/^(\* @@XTL_LEVELS@@ \*)$$/r_xtl_levels.mli.in' < $< > $@

_xtl_levels.ml.in _xtl_levels.mli.in _xtl_levels.h: genlevels.py xentoollog.h
	./genlevels.py _xtl_levels.mli.in _xtl_levels.ml.in _xtl_levels.h
