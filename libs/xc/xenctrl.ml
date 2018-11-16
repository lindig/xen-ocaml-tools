(*
 * Copyright (C) 2006-2007 XenSource Ltd.
 * Copyright (C) 2008      Citrix Ltd.
 * Author Vincent Hanquez <vincent.hanquez@eu.citrix.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation; version 2.1 only. with the special
 * exception on linking described in file LICENSE.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *)

(** *)
type domid = int

(* ** xenctrl.h ** *)

type vcpuinfo =
  {online: bool; blocked: bool; running: bool; cputime: int64; cpumap: int32}

type runstateinfo =
  { state: int32
  ; missed_changes: int32
  ; state_entry_time: int64
  ; time0: int64
  ; time1: int64
  ; time2: int64
  ; time3: int64
  ; time4: int64
  ; time5: int64 }

type domaininfo =
  { domid: domid
  ; dying: bool
  ; shutdown: bool
  ; paused: bool
  ; blocked: bool
  ; running: bool
  ; hvm_guest: bool
  ; shutdown_code: int
  ; total_memory_pages: nativeint
  ; max_memory_pages: nativeint
  ; shared_info_frame: int64
  ; cpu_time: int64
  ; nr_online_vcpus: int
  ; max_vcpu_id: int
  ; ssidref: int32
  ; handle: int array }

type sched_control = {weight: int; cap: int}

type physinfo_cap_flag = CAP_HVM | CAP_DirectIO

type physinfo =
  { threads_per_core: int
  ; cores_per_socket: int
  ; nr_cpus: int
  ; max_node_id: int
  ; cpu_khz: int
  ; total_pages: nativeint
  ; free_pages: nativeint
  ; scrub_pages: nativeint
  ; (* XXX hw_cap *)
    capabilities: physinfo_cap_flag list
  ; max_nr_cpus: int }

type version = {major: int; minor: int; extra: string}

type compile_info =
  { compiler: string
  ; compile_by: string
  ; compile_domain: string
  ; compile_date: string }

type shutdown_reason =
  | Poweroff
  | Reboot
  | Suspend
  | Crash
  | Watchdog
  | Soft_reset

type domain_create_flag = CDF_HVM | CDF_HAP

exception Error of string

type handle

external interface_open : unit -> handle = "mock1"

external interface_close : handle -> unit = "mock1"

let with_intf f =
  let xc = interface_open () in
  let r = try f xc with exn -> interface_close xc ; raise exn in
  interface_close xc ; r

external _domain_create :
  handle -> int32 -> domain_create_flag list -> int array -> domid
  = "mock4"

let int_array_of_uuid_string s =
  try
    Scanf.sscanf s
      "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x"
      (fun a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 ->
        [|a0; a1; a2; a3; a4; a5; a6; a7; a8; a9; a10; a11; a12; a13; a14; a15|]
    )
  with _ -> invalid_arg ("Xc.int_array_of_uuid_string: " ^ s)

let domain_create handle n flags uuid =
  _domain_create handle n flags (int_array_of_uuid_string uuid)

external _domain_sethandle :
  handle -> domid -> int array -> unit
  = "mock3"

let domain_sethandle handle n uuid =
  _domain_sethandle handle n (int_array_of_uuid_string uuid)

external domain_max_vcpus :
  handle -> domid -> int -> unit
  = "mock3"

external domain_pause : handle -> domid -> unit = "mock2"

external domain_unpause : handle -> domid -> unit = "mock2"

external domain_resume_fast : handle -> domid -> unit = "mock2"

external domain_destroy : handle -> domid -> unit = "mock2"

external domain_shutdown : handle -> domid -> shutdown_reason -> unit = "mock3"

external _domain_getinfolist :
  handle -> domid -> int -> domaininfo list
  = "mock3"

let domain_getinfolist handle first_domain =
  let nb = 2 in
  let last_domid l = (List.hd l).domid + 1 in
  let rec __getlist from =
    let l = _domain_getinfolist handle from nb in
    (if List.length l = nb then __getlist (last_domid l) else []) @ l
  in
  List.rev (__getlist first_domain)

external domain_getinfo : handle -> domid -> domaininfo = "mock2"

external domain_get_vcpuinfo : handle -> int -> int -> vcpuinfo = "mock3"

external domain_get_runstate_info : handle -> int -> runstateinfo = "mock2"

external domain_ioport_permission :
  handle -> domid -> int -> int -> bool -> unit
  = "mock5"

external domain_iomem_permission :
  handle -> domid -> nativeint -> nativeint -> bool -> unit
  = "mock5"

external domain_irq_permission :
  handle -> domid -> int -> bool -> unit
  = "mock4"

external vcpu_affinity_set :
  handle -> domid -> int -> bool array -> unit
  = "mock4"

external vcpu_affinity_get : handle -> domid -> int -> bool array = "mock3"

external vcpu_context_get : handle -> domid -> int -> string = "mock3"

external sched_id : handle -> int = "mock1"

external sched_credit_domain_set :
  handle -> domid -> sched_control -> unit
  = "mock3"

external sched_credit_domain_get : handle -> domid -> sched_control = "mock2"

external shadow_allocation_set : handle -> domid -> int -> unit = "mock3"

external shadow_allocation_get : handle -> domid -> int = "mock2"

external evtchn_alloc_unbound : handle -> domid -> domid -> int = "mock3"

external evtchn_reset : handle -> domid -> unit = "mock2"

external readconsolering : handle -> string = "mock1"

external send_debug_keys : handle -> string -> unit = "mock2"

external physinfo : handle -> physinfo = "mock1"

external pcpu_info : handle -> int -> int64 array = "mock2"

external domain_setmaxmem : handle -> domid -> int64 -> unit = "mock3"

external domain_set_memmap_limit : handle -> domid -> int64 -> unit = "mock3"

external domain_memory_increase_reservation :
  handle -> domid -> int64 -> unit
  = "mock3"

external domain_set_machine_address_size :
  handle -> domid -> int -> unit
  = "mock3"

external domain_get_machine_address_size : handle -> domid -> int = "mock2"

external domain_cpuid_set :
     handle
  -> domid
  -> int64 * int64 option
  -> string option array
  -> string option array
  = "mock4"

external domain_cpuid_apply_policy : handle -> domid -> unit = "mock2"

external cpuid_check :
     handle
  -> int64 * int64 option
  -> string option array
  -> bool * string option array
  = "mock3"

external map_foreign_range :
  handle -> domid -> int -> nativeint -> Xenmmap.mmap_interface
  = "mock4"

external domain_get_pfn_list :
  handle -> domid -> nativeint -> nativeint array
  = "mock3"

external domain_assign_device :
  handle -> domid -> int * int * int * int -> unit
  = "mock3"

external domain_deassign_device :
  handle -> domid -> int * int * int * int -> unit
  = "mock3"

external domain_test_assign_device :
  handle -> domid -> int * int * int * int -> bool
  = "mock3"

external hvm_check_pvdriver : handle -> domid -> bool = "mock2"
(** check if some hvm domain got pv driver or not *)

external version : handle -> version = "mock1"

external version_compile_info : handle -> compile_info = "mock1"

external version_changeset : handle -> string = "mock1"

external version_capabilities : handle -> string = "mock1"

type featureset_index =
  | Featureset_raw
  | Featureset_host
  | Featureset_pv
  | Featureset_hvm

external get_cpu_featureset :
  handle -> featureset_index -> int64 array
  = "mock2"

external get_featureset : handle -> featureset_index -> int64 array = "mock2"

external upgrade_oldstyle_featuremask :
  handle -> int64 array -> bool -> int64 array
  = "mock3"

external oldstyle_featuremask : handle -> int64 array = "mock1"

external watchdog : handle -> int -> int32 -> int = "mock3"

(* ** Misc ** *)

external pages_to_kib : int64 -> int64 = "mock1"
(**
   Convert the given number of pages to an amount in KiB, rounded up.
 *)

let pages_to_mib pages = Int64.div (pages_to_kib pages) 1024L

let _ = Callback.register_exception "xc.error" (Error "register_callback")
