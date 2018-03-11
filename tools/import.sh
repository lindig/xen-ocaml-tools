#! /bin/sh

XENROOT=${1:-$HOME/Development/xen}

FILES='
LICENSE
libs/eventchn/xeneventchn.ml
libs/eventchn/xeneventchn.mli
libs/eventchn/xeneventchn_stubs.c
libs/mmap/mmap_stubs.h
libs/mmap/xenmmap.ml
libs/mmap/xenmmap.mli
libs/mmap/xenmmap_stubs.c
libs/xb/op.ml
libs/xb/packet.ml
libs/xb/partial.ml
libs/xb/xb.ml
libs/xb/xb.mli
libs/xb/xenbus_stubs.c
libs/xb/xs_ring.ml
libs/xb/xs_ring_stubs.c
libs/xc/xenctrl.ml
libs/xc/xenctrl.mli
libs/xc/xenctrl_stubs.c
libs/xentoollog/caml_xentoollog.h
libs/xentoollog/genlevels.py
libs/xentoollog/xentoollog.ml.in
libs/xentoollog/xentoollog.mli.in
libs/xentoollog/xentoollog_stubs.c
libs/xl/genwrap.py
libs/xl/xenlight_stubs.c
libs/xs/queueop.ml
libs/xs/xs.ml
libs/xs/xs.mli
libs/xs/xsraw.ml
libs/xs/xsraw.mli
libs/xs/xst.ml
libs/xs/xst.mli
test/dmesg.ml
test/list_domains.ml
test/raise_exception.ml
test/send_debug_keys.ml
test/xtl.ml
xenstored/config.ml
xenstored/connection.ml
xenstored/connections.ml
xenstored/define.ml
xenstored/disk.ml
xenstored/domain.ml
xenstored/domains.ml
xenstored/event.ml
xenstored/history.ml
xenstored/logging.ml
xenstored/oxenstored.conf.in
xenstored/packet.ml
xenstored/parse_arg.ml
xenstored/perms.ml
xenstored/process.ml
xenstored/quota.ml
xenstored/stdext.ml
xenstored/store.ml
xenstored/select.ml
xenstored/select.mli
xenstored/select_stubs.c
xenstored/syslog.ml
xenstored/syslog.mli
xenstored/syslog_stubs.c
xenstored/systemd.ml
xenstored/systemd.mli
xenstored/systemd_stubs.c
xenstored/symbol.ml
xenstored/symbol.mli
xenstored/transaction.ml
xenstored/trie.ml
xenstored/trie.mli
xenstored/utils.ml
xenstored/xenstored.ml
'

EXTRA='
libxl/idl.py
libxl/libxl_types.idl
libs/toollog/include/xentoollog.h
'

(cd $XENROOT/tools/ocaml && tar cf - $FILES) | tar xf -
(cd xenstored; mv select* syslog* systemd* stubs/)

# This needs more work as files are not in the right place
# Also might want to do some patching right here
(cd $XENROOT/tools && tar cf - $EXTRA) | tar xf -
