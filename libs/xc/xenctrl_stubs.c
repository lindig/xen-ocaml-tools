/*
*/

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/fail.h>

static char *msg = "not implemented";

CAMLprim value mock1 (value v1)
{
  CAMLparam1 (v1);
  CAMLlocal1 (result);
  result = Val_int(0);
  caml_failwith(msg);
  CAMLreturn (result);
}

CAMLprim value mock2 (value v1, value v2)
{
  CAMLparam2 (v1, v2);
  CAMLlocal1 (result);
  result = Val_int(0);
  caml_failwith(msg);
  CAMLreturn (result);
}

CAMLprim value mock3 (value v1, value v2, value v3)
{
  CAMLparam3 (v1, v2, v3);
  CAMLlocal1 (result);
  result = Val_int(0);
  caml_failwith(msg);
  CAMLreturn (result);
}

CAMLprim value mock4 (value v1, value v2, value v3, value v4)
{
  CAMLparam4 (v1, v2, v3, v4);
  CAMLlocal1 (result);
  result = Val_int(0);
  caml_failwith(msg);
  CAMLreturn (result);
}

CAMLprim value mock5 (value v1, value v2, value v3, value v4, value v5)
{
  CAMLparam5 (v1, v2, v3, v4, v5);
  CAMLlocal1 (result);
  result = Val_int(0);
  caml_failwith(msg);
  CAMLreturn (result);
}
