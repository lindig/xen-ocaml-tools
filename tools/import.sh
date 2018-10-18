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

(cd $XENROOT/tools/ocaml && tar cf - $FILES) | tar xf -
(cd xenstored; mv select* syslog* systemd* stubs/)

cp $XENROOT/tools/libxl/idl.py libs/xl
cp $XENROOT/tools/libxl/libxl_types.idl libs/xl
cp $XENROOT/tools/libs/toollog/include/xentoollog.h libs/xentoollog

patch -p1 <<EOF
diff --git b/libs/xentoollog/genlevels.py a/libs/xentoollog/genlevels.py
index 8c233c5..098c481 100755
--- b/libs/xentoollog/genlevels.py
+++ a/libs/xentoollog/genlevels.py
@@ -3,7 +3,7 @@
 import sys

 def read_levels():
-	f = open('../../../libs/toollog/include/xentoollog.h', 'r')
+	f = open('xentoollog.h', 'r')

 	levels = []
 	record = False
diff --git b/libs/xentoollog/xentoollog_stubs.c a/libs/xentoollog/xentoollog_stubs.c
index aadc3d1..087edfe 100644
--- b/libs/xentoollog/xentoollog_stubs.c
+++ a/libs/xentoollog/xentoollog_stubs.c
@@ -50,7 +50,7 @@ static char * dup_String_val(value s)
 	return c;
 }

-#include "_xtl_levels.inc"
+#include "_xtl_levels.h"

 /* Option type support as per http://www.linux-nantes.org/~fmonnier/ocaml/ocaml-wrapping-c.php */
 #define Val_none Val_int(0)
diff --git b/libs/xl/xenlight_stubs.c a/libs/xl/xenlight_stubs.c
index 98b52b9..8d2c33d 100644
--- b/libs/xl/xenlight_stubs.c
+++ a/libs/xl/xenlight_stubs.c
@@ -417,7 +417,7 @@ static char *String_option_val(value v)
 	CAMLreturnT(char *, s);
 }

-#include "_libxl_types.inc"
+#include "_libxl_types.h"

 void async_callback(libxl_ctx *ctx, int rc, void *for_callback)
 {
EOF

(cd libs/xl; ./pregen.sh)
(cd libs/xentoollog/; ./pregen.sh)
