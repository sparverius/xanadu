(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Xanadu - Unleashing the Potential of Types!
** Copyright (C) 2018 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Start Time: October, 2018
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload
SYM = "./../SATS/symbol.sats"
//
(* ****** ****** *)
//
#staload
MAP = "./../SATS/symmap.sats"
#staload
ENV = "./../SATS/symenv.sats"
#staload
NMS = "./../SATS/nmspace.sats"
//
(* ****** ****** *)
//
#staload
FP0 = "./../SATS/filpath.sats"
//
(* ****** ****** *)

#staload "./../SATS/lexing.sats"
#staload "./../SATS/staexp1.sats"
#staload "./../SATS/dynexp1.sats"

(* ****** ****** *)

#staload "./../SATS/staexp2.sats"
#staload "./../SATS/dynexp2.sats"

(* ****** ****** *)

#staload "./../SATS/trans01.sats"
#staload "./../SATS/trans12.sats"

(* ****** ****** *)

local

val r0 = ref<int>(0)

in (* in-of-local *)

implement
sargid_new() = let
//
val n0 = r0[] + 1
val () = (r0[] := n0)
//
val
(pf,fpf|p0) = malloc_gc(i2sz(16))
val _(*bsz*) =
$extfcall
(int, "sprintf", p0, "$a(%i)", n0)
//
in
  $SYM.symbol_make
  ($UN.castvwtp0{string}((pf,fpf|p0)))
end // end of [sargid_new]

end // end of [local]

(* ****** ****** *)

local

val r0 = ref<int>(0)

in (* in-of-local *)

implement
dargid_new() = let
//
val n0 = r0[] + 1
val () = (r0[] := n0)
//
val
(pf,fpf|p0) = malloc_gc(i2sz(16))
val _(*bsz*) =
$extfcall
(int, "sprintf", p0, "$x(%i)", n0)
//
in
  $SYM.symbol_make
  ($UN.castvwtp0{string}((pf,fpf|p0)))
end // end of [dargid_new]

end // end of [local]

(* ****** ****** *)

absimpl
$NMS.nmitm_tbox = fmodenv

(* ****** ****** *)
//
implement
the_nmspace_open
  (menv) =
(
  $NMS.the_nmspace_ins(menv)
)
//
(* ****** ****** *)
//
local
//
vtypedef
res =
fmodenvopt_vt
//
fun
auxsym1
( cs
: List0_vt(char)
) : res =
let
val sym =
$SYM.symbol_make
(
$UN.castvwtp0{string}
(
string_make_rlist_vt($UN.castvwtp0(cs))
)
)
val opt =
the_sexpenv_find(sym)
in
case+ opt of
|
~None_vt() =>
 None_vt()
|
~Some_vt(s2i) =>
 (
 case+ s2i of
 | S2ITMfmodenv(menv) => Some_vt(menv)
 | _(*non-S2ITMfmodenv*) => None_vt(*void*)
 )
end // end of [auxsym1]
//
fun
auxsym2
( m0
: fmodenv
, cs
: List0_vt(char)
) : res =
let
val sym =
$SYM.symbol_make
(
$UN.castvwtp0{string}
(
string_make_rlist_vt($UN.castvwtp0(cs))
)
)
val opt = s2iopt where
{
  val
  ( pf0
  , fpf|p0) =
    fmodenv_get_s2imap(m0)
  // end of [val]
  val s2iopt =
    $MAP.symmap_search(!p0, sym)
  prval ((*void*)) =
    minus_v_addback(fpf, pf0 | m0)
  // end of [prval]
}
in
case+ opt of
|
~None_vt() =>
 None_vt()
|
~Some_vt(s2i) =>
 (
 case+ s2i of
 | S2ITMfmodenv(menv) => Some_vt(menv)
 | _(*non-S2ITMfmodenv*) => None_vt(*void*)
 )
end
//
fun
auxlst0
( p0
: ptr): res =
let
val c0 =
$UN.ptr0_get<char>(p0)
in
if
iseqz(c0)
then None_vt()
else
let
val p1 =
ptr_succ<char>(p0)
in
auxlst1(p1, list_vt_sing(c0))
end (* else] *)
end // end of [let] // auxlst0
and
auxlst1
( p0
: ptr
, cs
: List0_vt(char)): res =
let
val c0 =
$UN.ptr0_get<char>(p0)
val p1 = ptr_succ<char>(p0)
in
ifcase
|
iseqz(c0) =>
(
  auxsym1(cs)
)
|
(c0 = '.') =>
(
  auxsym1(cs)
)
|
(c0 = '$') =>
let
val
opt = auxsym1(cs)
in
case+ opt of
|
~None_vt() =>
 None_vt()
|
~Some_vt(m0) =>
 auxlst2
 (m0, p1, list_vt_sing(c0))
end // end of [let]
|
_(*else*) =>
(
  auxlst1
  (p1, list_vt_cons(c0, cs))
)
end // end of [let] // auxlst1
//
and
auxlst2
( m0
: fmodenv
, p0: ptr
, cs
: List0_vt(char)): res =
let
val c0 =
$UN.ptr0_get<char>(p0)
val p1 = ptr_succ<char>(p0)
in
ifcase
|
iseqz(c0) =>
(
  auxsym2(m0, cs)
)
|
(c0 = '.') =>
(
  auxsym2(m0, cs)
)
|
(c0 = '$') =>
let
val
opt = auxsym2(m0, cs)
in
case+ opt of
|
~None_vt() =>
 None_vt()
|
~Some_vt(m0) =>
 auxlst2
 (m0, p1, list_vt_sing(c0))
end // end of [let]
|
_(*else*) =>
(
  auxlst2
  (m0, p1, list_vt_cons(c0, cs))
)
end // end of [let] // auxlst2
//
in
//
implement
the_qualist_find
  (qua) =
(
case+
qua.node() of
|
T_IDENT_dlr(qua) =>
auxlst0(string2ptr(qua))
|
T_IDENT_qual(qua) =>
auxlst0(string2ptr(qua))
//
| _(* else *) => None_vt()
//
) where
{
(*
val () =
println!
("the_qualist_find: qua = ", qua)
*)
} (* where *) // the_qualist_find
//
end // end of [local]
//
(* ****** ****** *)

vtypedef
symenv(a:type) = $ENV.symenv(a)

(* ****** ****** *)
//
static
fun
the_sortenv_savecur((*void*)): void
and
the_sortenv_restore((*void*)): s2tmap
static
fun
the_sexpenv_savecur((*void*)): void
and
the_sexpenv_restore((*void*)): s2imap
static
fun
the_dexpenv_savecur((*void*)): void
and
the_dexpenv_restore((*void*)): d2imap
//
(* ****** ****** *)

local

vtypedef
fmodenv_struct =
@{
//
  path= fpath
//
, s2txt= s2tmap
, s2itm= s2imap
, d2itm= d2imap
, d2ecl= d2eclist
//
} // end of [fmodenv_struct]

absimpl
fmodenv_tbox = ref(fmodenv_struct)

in (* in-of-local *)

implement
fmodenv_make
( fp0
, s2ts, s2is, d2is, d2cs
) = let
//
val
(pfat, pfgc | p0) =
ptr_alloc<fmodenv_struct>()
//
prval () = mfree_gc_v_elim(pfgc)
//
  val () = p0->path := fp0
//
  val () = p0->s2txt := s2ts
  val () = p0->s2itm := s2is
  val () = p0->d2itm := d2is
  val () = p0->d2ecl := d2cs
//
in
//
  ref_make_viewptr(pfat | p0)
//
end // end of [fmodenv_make]

(* ****** ****** *)

implement
fmodenv_get_path
  (menv) =
  (p0->path) where
{
  val
  (vbox(pf) | p0) = ref_get_viewptr(menv)
} (* end of [fmodenv_get_path] *)

(* ****** ****** *)

local

extern
prfun
myassert
{a:vt0p}{l:addr}
(pf: !a@l): (a@l, minus_v(fmodenv, a@l))

in (* in-of-local *)

implement
fmodenv_get_s2tmap
  (menv) = let
//
  val
  (pfbox|p0) =
  ref_get_viewptr(menv)
  prval
  vbox( pf0 ) = pfbox
//
  prval
  (pf1, fpf1) = myassert(view@(p0->s2txt))
in
  (pf1, fpf1 | addr@(p0->s2txt))
end // end of [fmodenv_get_s2tmap]

implement
fmodenv_get_s2imap
  (menv) = let
//
  val
  (pfbox|p0) =
  ref_get_viewptr(menv)
  prval
  vbox( pf0 ) = pfbox
//
  prval
  (pf1, fpf1) = myassert(view@(p0->s2itm))
in
  (pf1, fpf1 | addr@(p0->s2itm))
end // end of [fmodenv_get_s2imap]

implement
fmodenv_get_d2imap
  (menv) = let
//
  val
  (pfbox|p0) =
  ref_get_viewptr(menv)
  prval
  vbox( pf0 ) = pfbox
//
  prval
  (pf1, fpf1) = myassert(view@(p0->d2itm))
in
  (pf1, fpf1 | addr@(p0->d2itm))
end // end of [fmodenv_get_d2imap]

end // end of [local]

(* ****** ****** *)

implement
fmodenv_get_d2eclist
  (menv) =
  (p0 -> d2ecl) where
{
  val (vbox(pf0)|p0) = ref_get_viewptr(menv)
} (* end of [fmodenv_get_d2eclist] *)

(* ****** ****** *)

end // end of [local] *)

(* ****** ****** *)

local
//
absimpl
sortenv_view = unit_v
//
vtypedef
  s2tenv = symenv(s2txt)
//
extern
prfun
vbox_make_viewptr
{a:vt0p}{l:addr}
( pf: a @ l
| p0: ptr(l)):<> vbox(a @ l)
//
val
( pf
| p0) =
$ENV.symenv_make_nil((*void*))
//
prval
pfbox =
vbox_make_viewptr{s2tenv}(pf|p0)
//
fun
the_nmspace_find
  (tid: sym_t): s2txtopt_vt =
let
  fun
  fopr
  ( menv
  : fmodenv)
  : s2txtopt_vt = s2topt where
  {
    val
    ( pf0
    , fpf|p0) =
      fmodenv_get_s2tmap(menv)
    // end of [val]
    val s2topt =
      $MAP.symmap_search(!p0, tid)
    prval ((*void*)) =
      minus_v_addback(fpf, pf0 | menv)
    // end of [prval]
  }
in
  $NMS.the_nmspace_find(lam(x) => fopr(x))
end // end of [the_nmspace_find]
//
in (* in-of-local *)

implement
the_sortenv_add
  (tid, s2t) = let
  prval
  vbox(pf) = pfbox
in
  $ENV.symenv_insert(!p0, tid, s2t)
end // end of [the_sortenv_add]

(* ****** ****** *)

implement
the_sortenv_padd
  (tid, s2t) = let
  prval
  vbox(pf) = pfbox
in
  $ENV.symenv_pinsert(!p0, tid, s2t)
end // end of [the_sortenv_padd]

(* ****** ****** *)

implement
the_sortenv_find
  (tid) = let
val ans = let
  prval
  vbox(pf) = pfbox
in
$ENV.symenv_search{s2txt}(!p0, tid)
end // end of [val]
in
//
case+ ans of
//
| Some_vt _ => ans
//
| ~None_vt() => let
    val ans = the_nmspace_find(tid)
  in
    case+ ans of
    | Some_vt _ => ans
    | ~None_vt() => let
        prval
        vbox(pf) = pfbox
      in
        $ENV.symenv_psearch{s2txt}(!p0, tid)
      end // end of [None_vt]
  end // end of [None_vt]
//
end // end of [the_sortenv_find]

(* ****** ****** *)

implement
the_sortenv_qfind
  (qua, sym) = let
//
val
opt =
the_qualist_find(qua)
//
in
//
case+ opt of
|
~None_vt() =>
 None_vt()
|
~Some_vt(menv) =>
 ( s2topt ) where
{
  val
  ( pf0
  , fpf|p0) =
    fmodenv_get_s2tmap(menv)
  // end of [val]
  val s2topt =
    $MAP.symmap_search(!p0, sym)
  prval ((*void*)) =
    minus_v_addback(fpf, pf0 | menv)
  // end of [prval]
}
//
end // end of [the_sortenv_qfind]

(* ****** ****** *)

implement
the_sortenv_pop
(
  pfenv | (*none*)
) = let
  prval vbox(pf) = pfbox
  prval unit_v() = pfenv
in
  $effmask_ref
  ($ENV.symenv_pop{s2txt}(!p0))
end // end of [the_sortenv_pop]

implement
the_sortenv_popfree
  (pfenv | (*none*)) =
{
  prval vbox(pf) = pfbox
  prval unit_v() = pfenv
  val () =
  $effmask_ref
  ($ENV.symenv_popfree{s2txt}(!p0))
} // end of [the_sortenv_popfree]

implement
the_sortenv_pushnil
  () = (pfenv | ()) where
{
//
  prval pfenv = unit_v()
  prval vbox(pf) = pfbox
//
  val () =
  $effmask_ref
  ($ENV.symenv_pushnil{s2txt}(!p0))
//
} // end of [the_sortenv_pushnil]

(* ****** ****** *)

implement
the_sortenv_locjoin
(pf1, pf2| (*void*) ) =
{
//
  prval unit_v() = pf1
  prval unit_v() = pf2
//
  prval vbox(pf) = pfbox
//
  val () =
  $effmask_ref
  ($ENV.symenv_locjoin{s2txt}(!p0))
//
} // end of [the_sortenv_locjoin]

(* ****** ****** *)

implement
the_sortenv_pjoinwth0
  (map) = let
  prval
  vbox(pf) = pfbox in
  $effmask_ref
  ($ENV.symenv_pjoinwth0(!p0, map))
end // end of [the_sortenv_pjoinwth0]
implement
the_sortenv_pjoinwth1
  (map) = let
  prval
  vbox(pf) = pfbox in
  $effmask_ref
  ($ENV.symenv_pjoinwth1(!p0, map))
end // end of [the_sortenv_pjoinwth1]

(* ****** ****** *)

implement
the_sortenv_savecur
  ((*void*)) =
let
prval
vbox(pf) = pfbox
in
  $effmask_ref($ENV.symenv_savecur(!p0))
end
implement
the_sortenv_restore
  ((*void*)) =
let
prval
vbox(pf) = pfbox
in
  $effmask_ref($ENV.symenv_restore(!p0))
end

(* ****** ****** *)

local

fun
fprintln_s2txt
( out
: FILEref
, s2t: s2txt) = fprintln!(out, s2t)

in (* in-of-local *)

implement
the_sortenv_fprint
  (out) = let
//
prval vbox(pf) = pfbox
//
in (* let *)
//
$effmask_ref
(
fprintln!(out, "top:");
$ENV.fprint_symenv_top
( out, !p0
, lam(out, x) => fprintln_s2txt(out, x));
(*
fprintln!(out, "ptop:");
$ENV.fprint_symenv_ptop
( out, !p0
, lam(out, x) => fprintln_s2txt(out, x));
*)
)
//
end // end of [the_sortenv_print]

end // end of [local]

implement
the_sortenv_println
  ((*void*)) = let
  val out = stdout_ref
in
  the_sortenv_fprint(out); fprint_newline(out)
end // end of [the_sortenv_println]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

local
//
absimpl
sexpenv_view = unit_v
//
vtypedef
  s2ienv = symenv(s2itm)
//
extern
prfun
vbox_make_viewptr
{a:vt0p}{l:addr}
( pf: a @ l
| p0: ptr(l)):<> vbox(a @ l)
//
val
( pf
| p0) =
$ENV.symenv_make_nil((*void*))
//
prval
pfbox =
vbox_make_viewptr{s2ienv}(pf|p0)
//
fun
the_nmspace_find
  (tid: sym_t): s2itmopt_vt =
let
  fun
  fopr
  (menv: fmodenv): s2itmopt_vt =
    s2iopt where
  {
    val
    ( pf0
    , fpf|p0) =
      fmodenv_get_s2imap(menv)
    val s2iopt =
      $MAP.symmap_search(!p0, tid)
    prval ((*void*)) =
      minus_v_addback(fpf, pf0 | menv)
    // end of [prval]
  }
in
  $NMS.the_nmspace_find(lam(x) => fopr(x))
end // end of [the_nmspace_find]
//
in (* in-of-local *)

implement
the_sexpenv_add
  (sid, s2i) = let
  prval
  vbox(pf) = pfbox
in
  $ENV.symenv_insert(!p0, sid, s2i)
end // end of [the_sexpenv_add]

implement
the_sexpenv_add_cst
  (s2c) =
(
let
  prval
  vbox(pf) = pfbox
in
  $ENV.symenv_insert(!p0, sid, s2i0)
end
) where
{
//
val sid = s2c.sym()
val opt = the_sexpenv_find(sid)
//
val s2cs =
(
  case+ opt of
  | ~None_vt() =>
    (
      list_nil((*void*))
    )
  | ~Some_vt(s2i) =>
    (
    case+ s2i of
    | S2ITMcst(cs) => cs | _ => list_nil()
    )
) : s2cstlst // end of [val]
//
val s2i0 = S2ITMcst(list_cons(s2c, s2cs))
//
} (* end of [the_sexpenv_add_cst] *)

implement
the_sexpenv_add_var
  (s2v) =
(
let
//
  val
  sid = s2v.sym()
//
  prval
  vbox(pf) = pfbox
//
in
  $ENV.symenv_insert(!p0, sid, S2ITMvar(s2v))
end
) (* end of [the_sexpenv_add_var] *)

(* ****** ****** *)

implement
the_sexpenv_add_cstlst
  (s2cs) =
(
  foreach(s2cs)
) where
{
  fun
  foreach
  (s2cs: s2cstlst): void =
  (
  case+ s2cs of
  | list_nil() => ()
  | list_cons(s2c0, s2cs) =>
    (the_sexpenv_add_cst(s2c0); foreach(s2cs))
  )
} (* end of [the_sexpenv_add_cstlst] *)

implement
the_sexpenv_add_varlst
  (s2vs) =
(
  foreach(s2vs)
) where
{
  fun
  foreach
  (s2vs: s2varlst): void =
  (
  case+ s2vs of
  | list_nil() => ()
  | list_cons(s2v0, s2vs) =>
    (the_sexpenv_add_var(s2v0); foreach(s2vs))
  )
} (* end of [the_sexpenv_add_varlst] *)

implement
the_sexpenv_add_varlstlst
  (svss) =
(
  foreach(svss)
) where
{
  fun
  foreach
  (svss: s2varlstlst): void =
  (
  case+ svss of
  | list_nil() => ()
  | list_cons(s2vs, svss) =>
    (the_sexpenv_add_varlst(s2vs); foreach(svss))
  )
} (* end of [the_sexpenv_add_varlstlst] *)

(* ****** ****** *)

implement
the_sexpenv_find
  (sid) = let
  val ans = let
    prval
    vbox(pf) = pfbox
  in
    $ENV.symenv_search{s2itm}(!p0, sid)
  end // end of [val]
in
//
case+ ans of
//
| Some_vt _ => ans
//
| ~None_vt() => let
    val ans = the_nmspace_find(sid)
  in
    case+ ans of
    | Some_vt _ => ans
    | ~None_vt() => let
        prval
        vbox(pf) = pfbox
      in
        $ENV.symenv_psearch{s2itm}(!p0, sid)
      end // end of [None_vt]
  end // end of [None_vt]
//
end // end of [the_sexpenv_find]

(* ****** ****** *)

implement
the_sexpenv_pfind
  (sid) = let
  prval
  vbox(pf) = pfbox
in
  $ENV.symenv_psearch{s2itm}(!p0, sid)
end // end of [the_sexpenv_pfind]

(* ****** ****** *)

(*
implement
the_sexpenv_qfind
  (qua, sym) = let
//
val-
T_IDENT_qual
(qua) = qua.node()
val qua =
$SYM.symbol_make(qua)
val opt =
the_sexpenv_find(qua)
//
in
//
case+ opt of
| ~None_vt() =>
   None_vt()
| ~Some_vt(s2i) =>
  (
  case+ s2i of
  | S2ITMfmodenv
    (menv) => s2iopt where
    {
      val
      ( pf0
      , fpf|p0) =
        fmodenv_get_s2imap(menv)
      // end of [val]
      val s2iopt =
        $MAP.symmap_search(!p0, sym)
      prval ((*void*)) =
        minus_v_addback(fpf, pf0 | menv)
      // end of [prval]
    }
  | _(*non-S2ITMfmodenv*) => None_vt()
  ) (* end of [Some_vt] *)
//
end // end of [the_sexpenv_qfind]
*)
implement
the_sexpenv_qfind
  (qua, sym) = let
//
val
opt =
the_qualist_find(qua)
//
in
//
case+ opt of
|
~None_vt() =>
 None_vt()
|
~Some_vt(menv) =>
 ( s2iopt ) where
{
  val
  ( pf0
  , fpf|p0) =
    fmodenv_get_s2imap(menv)
  // end of [val]
  val s2iopt =
    $MAP.symmap_search(!p0, sym)
  prval ((*void*)) =
    minus_v_addback(fpf, pf0 | menv)
  // end of [prval]
}
//
end // end of [the_sexpenv_qfind]

(* ****** ****** *)

implement
the_sexpenv_pop (
  pfenv | (*none*)
) = let
  prval vbox(pf) = pfbox
  prval unit_v() = pfenv
in
  $effmask_ref
  ($ENV.symenv_pop{s2itm}(!p0))
end // end of [the_sexpenv_pop]

implement
the_sexpenv_popfree
  (pfenv | (*none*)) =
{
  prval vbox(pf) = pfbox
  prval unit_v() = pfenv
  val () =
  $effmask_ref
  ($ENV.symenv_popfree{s2itm}(!p0))
} // end of [the_sexpenv_popfree]

implement
the_sexpenv_pushnil
  () = (pfenv | ()) where
{
//
  prval pfenv = unit_v()
  prval vbox(pf) = pfbox
//
  val () =
  $effmask_ref
  ($ENV.symenv_pushnil{s2itm}(!p0))
//
} // end of [the_sexpenv_pushnil]

(* ****** ****** *)

implement
the_sexpenv_locjoin
(pf1, pf2| (*void*) ) =
{
//
  prval unit_v() = pf1
  prval unit_v() = pf2
//
  prval vbox(pf) = pfbox
//
  val () =
  $effmask_ref
  ($ENV.symenv_locjoin{s2itm}(!p0))
//
} // end of [the_sexpenv_locjoin]

(* ****** ****** *)

implement
the_sexpenv_pjoinwth0
  (map) = let
  prval
  vbox(pf) = pfbox in
  $effmask_ref
  ($ENV.symenv_pjoinwth0(!p0, map))
end // end of [the_sexpenv_pjoinwth0]
implement
the_sexpenv_pjoinwth1
  (map) = let
  prval
  vbox(pf) = pfbox in
  $effmask_ref
  ($ENV.symenv_pjoinwth1(!p0, map))
end // end of [the_sexpenv_pjoinwth1]

(* ****** ****** *)

implement
the_sexpenv_savecur
  ((*void*)) =
let
prval
vbox(pf) = pfbox
in
  $effmask_ref($ENV.symenv_savecur(!p0))
end
implement
the_sexpenv_restore
  ((*void*)) =
let
prval
vbox(pf) = pfbox
in
  $effmask_ref($ENV.symenv_restore(!p0))
end

(* ****** ****** *)

local

fun
fprintln_s2itm
( out
: FILEref
, s2i: s2itm) = fprintln!(out, s2i)

in (* in-of-local *)

implement
the_sexpenv_fprint
  (out) = let
//
prval vbox(pf) = pfbox
//
in (* let *)
//
$effmask_ref
(
fprintln!(out, "top:");
$ENV.fprint_symenv_top
( out, !p0
, lam(out, x) => fprintln_s2itm(out, x));
(*
fprintln!(out, "ptop:");
$ENV.fprint_symenv_ptop
( out, !p0
, lam(out, x) => fprintln_s2itm(out, x));
*)
)
//
end // end of [the_sexpenv_print]

end // end of [local]

implement
the_sexpenv_println
  ((*void*)) = let
  val out = stdout_ref
in
  the_sexpenv_fprint(out); fprint_newline(out)
end // end of [the_sexpenv_println]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

local
//
absimpl
dexpenv_view = unit_v
//
vtypedef
  d2ienv = symenv(d2itm)
//
extern
prfun
vbox_make_viewptr
{a:vt0p}{l:addr}
( pf: a @ l
| p0: ptr(l)):<> vbox(a @ l)
//
val
( pf
| p0) =
$ENV.symenv_make_nil((*void*))
//
prval
pfbox =
vbox_make_viewptr{d2ienv}(pf|p0)
//
fun
the_nmspace_find
  (tid: sym_t): d2itmopt_vt =
let
  fun
  fopr
  ( menv
  : fmodenv )
  : d2itmopt_vt = d2iopt where
  {
    val
    ( pf0
    , fpf|p0) =
      fmodenv_get_d2imap(menv)
    // end of [val]
    val d2iopt =
      $MAP.symmap_search(!p0, tid)
    prval ((*void*)) =
      minus_v_addback(fpf, pf0 | menv)
    // end of [prval]
  }
in
  $NMS.the_nmspace_find(lam(x) => fopr(x))
end // end of [the_nmspace_find]
//
in (* in-of-local *)

implement
the_dexpenv_add
  (sym, d2i) = let
  prval
  vbox(pf) = pfbox
in
  $ENV.symenv_insert(!p0, sym, d2i)
end // end of [the_dexpenv_add]

(* ****** ****** *)

implement
the_dexpenv_add_var
  (d2v) =
(
let
//
  val
  sym = d2v.sym()
//
  prval
  vbox(pf) = pfbox
//
in
  $ENV.symenv_insert(!p0, sym, D2ITMvar(d2v))
end
) (* end of [the_dexpenv_add_var] *)

(* ****** ****** *)

implement
the_dexpenv_add_con
  (d2c) =
(
let
  prval
  vbox(pf) = pfbox
in
  $ENV.symenv_insert(!p0, sym, d2i0)
end
) where
{
//
val sym = d2c.sym()
val opt = the_dexpenv_find(sym)
//
val d2cs =
(
  case+ opt of
  | ~None_vt() =>
    (
      list_nil((*void*))
    )
  | ~Some_vt(d2i) =>
    (
    case+ d2i of
    | D2ITMcon(cs) => cs | _ => list_nil()
    )
) : d2conlst // end of [val]
//
val d2i0 = D2ITMcon(list_cons(d2c, d2cs))
//
} (* end of [the_dexpenv_add_con] *)

(* ****** ****** *)

implement
the_dexpenv_add_cst
  (d2c) =
(
let
  prval
  vbox(pf) = pfbox
in
  $ENV.symenv_insert(!p0, sym, d2i0)
end
) where
{
//
val sym = d2c.sym()
val opt = the_dexpenv_find(sym)
//
val d2cs =
(
  case+ opt of
  | ~None_vt() =>
    (
      list_nil((*void*))
    )
  | ~Some_vt(d2i) =>
    (
    case+ d2i of
    | D2ITMcst(cs) => cs | _ => list_nil()
    )
) : d2cstlst // end of [val]
//
val d2i0 = D2ITMcst(list_cons(d2c, d2cs))
//
} (* end of [the_dexpenv_add_cst] *)

(* ****** ****** *)

implement
the_dexpenv_add_conlst
  (d2cs) =
(
  foreach(d2cs)
) where
{
  fun
  foreach
  (d2cs: d2conlst): void =
  (
  case+ d2cs of
  | list_nil() => ()
  | list_cons(d2c0, d2cs) =>
    (the_dexpenv_add_con(d2c0); foreach(d2cs))
  )
} (* end of [the_dexpenv_add_conlst] *)

(* ****** ****** *)

implement
the_dexpenv_add_cstlst
  (d2cs) =
(
  foreach(d2cs)
) where
{
  fun
  foreach
  (d2cs: d2cstlst): void =
  (
  case+ d2cs of
  | list_nil() => ()
  | list_cons(d2c0, d2cs) =>
    (the_dexpenv_add_cst(d2c0); foreach(d2cs))
  )
} (* end of [the_dexpenv_add_conlst] *)

(* ****** ****** *)

implement
the_dexpenv_add_varlst
  (d2vs) =
(
  foreach(d2vs)
) where
{
  fun
  foreach
  (d2vs: d2varlst): void =
  (
  case+ d2vs of
  | list_nil() => ()
  | list_cons(d2v0, d2vs) =>
    (the_dexpenv_add_var(d2v0); foreach(d2vs))
  )
} (* end of [the_dexpenv_add_varlst] *)

(* ****** ****** *)

implement
the_dexpenv_find
  (sym) = let
  val ans = let
    prval
    vbox(pf) = pfbox
  in
    $ENV.symenv_search{d2itm}(!p0, sym)
  end // end of [val]
in
//
case+ ans of
//
| Some_vt _ => ans
//
| ~None_vt() => let
    val ans = the_nmspace_find(sym)
  in
    case+ ans of
    | Some_vt _ => ans
    | ~None_vt() => let
        prval
        vbox(pf) = pfbox
      in
        $ENV.symenv_psearch{d2itm}(!p0, sym)
      end // end of [None_vt]
  end // end of [None_vt]
//
end // end of [the_dexpenv_find]

(* ****** ****** *)

(*
implement
the_dexpenv_qfind
  (qua, sym) = let
//
val-
T_IDENT_qual
(qua) = qua.node()
val qua =
$SYM.symbol_make(qua)
val opt =
the_sexpenv_find(qua)
//
in
//
case+ opt of
| ~None_vt() =>
   None_vt()
| ~Some_vt(s2i) =>
  (
  case+ s2i of
  | S2ITMfmodenv
    (menv) => d2iopt where
    {
      val
      ( pf0
      , fpf|p0) =
        fmodenv_get_d2imap(menv)
      // end of [val]
      val d2iopt =
        $MAP.symmap_search(!p0, sym)
      prval ((*void*)) =
        minus_v_addback(fpf, pf0 | menv)
      // end of [prval]
    }
  | _(*non-S2ITMfmodenv*) => None_vt()
  ) (* end of [Some_vt] *)
//
end // end of [the_dexpenv_qfind]
*)
implement
the_dexpenv_qfind
  (qua, sym) = let
//
val
opt =
the_qualist_find(qua)
//
in
//
case+ opt of
|
~None_vt() =>
 None_vt()
|
~Some_vt(menv) =>
 ( d2iopt ) where
{
  val
  ( pf0
  , fpf|p0) =
    fmodenv_get_d2imap(menv)
  // end of [val]
  val d2iopt =
    $MAP.symmap_search(!p0, sym)
  prval ((*void*)) =
    minus_v_addback(fpf, pf0 | menv)
  // end of [prval]
}
//
end // end of [the_dexpenv_qfind]

(* ****** ****** *)

implement
the_dexpenv_pop (
  pfenv | (*none*)
) = let
  prval vbox(pf) = pfbox
  prval unit_v() = pfenv
in
  $effmask_ref
  ($ENV.symenv_pop{d2itm}(!p0))
end // end of [the_dexpenv_pop]

implement
the_dexpenv_popfree
  (pfenv | (*none*)) =
{
  prval vbox(pf) = pfbox
  prval unit_v() = pfenv
  val () =
  $effmask_ref
  ($ENV.symenv_popfree{d2itm}(!p0))
} // end of [the_dexpenv_popfree]

implement
the_dexpenv_pushnil
  () = (pfenv | ()) where
{
//
  prval pfenv = unit_v()
  prval vbox(pf) = pfbox
//
  val () =
  $effmask_ref
  ($ENV.symenv_pushnil{d2itm}(!p0))
//
} // end of [the_dexpenv_pushnil]

(* ****** ****** *)

implement
the_dexpenv_locjoin
(pf1, pf2| (*void*) ) =
{
//
  prval unit_v() = pf1
  prval unit_v() = pf2
//
  prval vbox(pf) = pfbox
//
  val () =
  $effmask_ref
  ($ENV.symenv_locjoin{d2itm}(!p0))
//
} // end of [the_dexpenv_locjoin]

(* ****** ****** *)

implement
the_dexpenv_pjoinwth0
  (map) = let
  prval
  vbox(pf) = pfbox in
  $effmask_ref
  ($ENV.symenv_pjoinwth0(!p0, map))
end // end of [the_dexpenv_pjoinwth0]
implement
the_dexpenv_pjoinwth1
  (map) = let
  prval
  vbox(pf) = pfbox in
  $effmask_ref
  ($ENV.symenv_pjoinwth1(!p0, map))
end // end of [the_dexpenv_pjoinwth1]

(* ****** ****** *)

implement
the_dexpenv_savecur
  ((*void*)) =
let
prval
vbox(pf) = pfbox
in
  $effmask_ref($ENV.symenv_savecur(!p0))
end
implement
the_dexpenv_restore
  ((*void*)) =
let
prval
vbox(pf) = pfbox
in
  $effmask_ref($ENV.symenv_restore(!p0))
end

(* ****** ****** *)

local

fun
fprintln_d2itm
( out
: FILEref
, d2i: d2itm) = fprintln!(out, d2i)

in (* in-of-local *)

implement
the_dexpenv_fprint
  (out) = let
//
prval vbox(pf) = pfbox
//
in (* let *)
//
$effmask_ref
(
fprintln!(out, "top:");
$ENV.fprint_symenv_top
( out, !p0
, lam(out, x) => fprintln_d2itm(out, x));
(*
fprintln!(out, "ptop:");
$ENV.fprint_symenv_ptop
( out, !p0
, lam(out, x) => fprintln_d2itm(out, x));
*)
)
//
end // end of [the_dexpenv_print]

end // end of [local]

implement
the_dexpenv_println
  ((*void*)) = let
  val out = stdout_ref
in
  the_dexpenv_fprint(out); fprint_newline(out)
end // end of [the_dexpenv_println]

end // end of [local]

(* ****** ****** *)

local

vtypedef
symmap =
$MAP.symmap(fmodenv)

val
the_fmodenv =
ref<symmap>
($MAP.symmap_make_nil())

in (* in of [local] *)

implement
the_fmodenvmap_add
  (fid, env) = let
  val
  (vbox(pf)|p0) =
  ref_get_viewptr(the_fmodenv)
in
  $MAP.symmap_insert(!p0, fid, env)
end // end of [the_fmodenvmap_add]

implement
the_fmodenvmap_find
  (fid) = let
  val
  (vbox(pf)|p0) =
  ref_get_viewptr(the_fmodenv)
in
  $MAP.symmap_search{fmodenv}(!p0, fid)
end // end of [the_fmodenvmap_find]

end // end of [local]

(* ****** ****** *)

local

absimpl
trans12_view = unit_v

in (* in-of-local *)

implement
the_trans12_popfree
  (pfenv | (*void*)) =
{
//
prval
unit_v() = pfenv
//
val
((*void*)) =
$NMS.the_nmspace_pop()
//
local
extern
prfun _assert_{vw:view}(): vw
in // in-of-local
(*
val ((*void*)) =
the_fxtyenv_popfree(_assert_() | (*void*))
*)
val ((*void*)) =
the_sortenv_popfree(_assert_() | (*void*))
val ((*void*)) =
the_sexpenv_popfree(_assert_() | (*void*))
val ((*void*)) =
the_dexpenv_popfree(_assert_() | (*void*))
end // end of [local]
//
} (* end of [the_trans12_popfree] *)

implement
the_trans12_pushnil
  ((*void*)) =
  (pf | ()) where
{
//
prval pf = unit_v
//
val
((*void*)) =
$NMS.the_nmspace_push()
//
(*
val
(pf0_ | ()) = the_fxtyenv_push()
*)
//
val
(pf1_ | ()) = the_sortenv_pushnil()
val
(pf2_ | ()) = the_sexpenv_pushnil()
val
(pf3_ | ()) = the_dexpenv_pushnil()
//
(*
prval () = $UN.castview0{void}(pf0_)
*)
prval () = $UN.castview0{void}(pf1_)
prval () = $UN.castview0{void}(pf2_)
prval () = $UN.castview0{void}(pf3_)
//
} (* end of [the_trans12_pushnil] *)

implement
the_trans12_locjoin
(pf1, pf2| (*void*)) =
{
//
prval unit_v() = pf1
prval unit_v() = pf2
//
val
((*void*)) =
$NMS.the_nmspace_locjoin()
//
local
extern
prfun _assert_{vw:view}(): vw
in // in-of-local
(*
val ((*void*)) =
the_fxtyenv_locjoin
(_assert_(), _assert_() | (*void*))
*)
val ((*void*)) =
the_sortenv_locjoin
(_assert_(), _assert_() | (*void*))
val ((*void*)) =
the_sexpenv_locjoin
(_assert_(), _assert_() | (*void*))
val ((*void*)) =
the_dexpenv_locjoin
(_assert_(), _assert_() | (*void*))
end // end of [local]
//
} // end of [the_trans12_locjoin]

(* ****** ****** *)

implement
the_trans12_pjoinwth0
  (pf0 | (*void*)) =
{
//
  prval unit_v() = pf0
//
local
extern
prfun _assert_{vw:view}(): vw
in // in-of-local
//
  val m0 =
  the_sortenv_pop
  (_assert_() | (*none*))
  val () = the_sortenv_pjoinwth0(m0)
//
  val m1 =
  the_sexpenv_pop
  (_assert_() | (*none*))
  val () = the_sexpenv_pjoinwth0(m1)
//
  val m2 =
  the_dexpenv_pop
  (_assert_() | (*none*))
  val () = the_dexpenv_pjoinwth0(m2)
//
end // end of [local]
//
} (* end of [the_trans12_pjoinwth0] *)

implement
the_trans12_pjoinwth1
  (pf0 | fp0, d2cs) =
{
//
  prval unit_v() = pf0
//
local
extern
prfun _assert_{vw:view}(): vw
in // in-of-local
//
  val m0 =
  the_sortenv_pop
  (_assert_() | (*none*))
  val () = the_sortenv_pjoinwth1(m0)
//
  val m1 =
  the_sexpenv_pop
  (_assert_() | (*none*))
  val () = the_sexpenv_pjoinwth1(m1)
//
  val m2 =
  the_dexpenv_pop
  (_assert_() | (*none*))
  val () = the_dexpenv_pjoinwth1(m2)
//
  val fid =
  $FP0.filpath_get_full2(fp0)
  val env =
  fmodenv_make(fp0, m0, m1, m2, d2cs)
//
  val ( ) = the_fmodenvmap_add(fid, env)
//
end // end of [local]
//
} (* end of [the_trans12_pjoinwth1] *)

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

local

absimpl
trans12_save_view = unit_v

in (* in-of-local *)

implement
the_trans12_savecur
  ((*void*)) =
(
  (pf | ())
) where
{
//
prval pf = unit_v(*void*)
//
  val () = the_sortenv_savecur()
  val () = the_sexpenv_savecur()
  val () = the_dexpenv_savecur()
//
  val () = $NMS.the_nmspace_savecur()
//
} (* end of [the_trans12_savecur] *)

implement
the_trans12_restore
  (pf | (*void*)) =
let
//
prval unit_v() = pf
//
in
let
val
s2tenv =
the_sortenv_restore()
val
s2ienv =
the_sexpenv_restore()
val
d2ienv =
the_dexpenv_restore()
//
val ((*void*)) = $NMS.the_nmspace_restore()
//
in
  (s2tenv, s2ienv, d2ienv)
end
end (* end of [the_trans12_restore] *)

end // end of [local]

(* ****** ****** *)

local

fun
auxd2p0
(d2p0: d2pat): void =
(
case+
d2p0.node() of
//
| D2Pvar(d2v) =>
  the_dexpenv_add_var(d2v)
//
| D2Pflat(d2p1) =>
  {
    val () = auxd2p0(d2p1)
  }
| D2Pfree(d2p1) =>
  {
    val () = auxd2p0(d2p1)
  }
//
| D2Pdapp
  (d2p1, npf2, d2ps) =>
  {
    val () = auxd2p0(d2p1)
    val () = auxd2ps(d2ps)  
  }
//
| D2Ptuple
  (knd0, npf1, d2ps) =>
  {
    val () = auxd2ps(d2ps)
  }
//
| D2Panno
  (d2p, s2e) => auxd2p0(d2p)
//
| _(* rest-of-d2pat *) => ()
)

and
auxd2ps
(d2ps: d2patlst): void =
(
case+ d2ps of
| list_nil() => ()
| list_cons(d2p0, d2ps) =>
    (auxd2p0(d2p0); auxd2ps(d2ps))
  // end of [list_cons]
)

fun
auxd2g0
(d2g0: d2gua): void =
(
case+
d2g0.node() of
| D2GUAexp _ => ()
| D2GUAmat(_, d2p) => auxd2p0(d2p)
)
fun
auxd2gs
(d2gs: d2gualst): void =
(
case+ d2gs of
| list_nil() => ()
| list_cons(d2g0, d2gs) =>
    (auxd2g0(d2g0); auxd2gs(d2gs))
  // end of [list_cons]
)

fun
auxd2gp
(d2gp: d2gpat): void =
(
case+
d2gp.node() of
| D2GPATpat(d2p) =>
    auxd2p0(d2p)
| D2GPATgua(d2p, d2gs) =>
    (auxd2p0(d2p); auxd2gs(d2gs))
)

in (* in-of-local *)
//
implement
the_trans12_add_pat(d2p0) = auxd2p0(d2p0)
implement
the_trans12_add_patlst(d2ps) = auxd2ps(d2ps)
//
implement
the_trans12_add_gua(d2g0) = auxd2g0(d2g0)
implement
the_trans12_add_gpat(d2gp) = auxd2gp(d2gp)
implement
the_trans12_add_gualst(d2gs) = auxd2gs(d2gs)
//
end // end of [local]

(* ****** ****** *)
//
implement
trans12_staload_add
( fp0
, menv) =
let
val fid =
$FP0.filpath_get_full2(fp0)
in
  the_fmodenvmap_add(fid, menv)
end
implement
trans12_staload_find
  (fp0) =
(
  the_fmodenvmap_find
  ($FP0.filpath_get_full2(fp0))
)
//
(* ****** ****** *)

local
//
val
s2tx_int = S2TXTsrt(the_sort2_int)
val
s2tx_addr = S2TXTsrt(the_sort2_addr)
val
s2tx_bool = S2TXTsrt(the_sort2_bool)
val
s2tx_char = S2TXTsrt(the_sort2_char)
//
val
s2tx_prop = S2TXTsrt(the_sort2_prop)
val
s2tx_view = S2TXTsrt(the_sort2_view)
//
val
s2tx_tbox = S2TXTsrt(the_sort2_tbox)
val
s2tx_tflt = S2TXTsrt(the_sort2_tflt)
//
val
s2tx_vtbox = S2TXTsrt(the_sort2_vtbox)
val
s2tx_vtflt = S2TXTsrt(the_sort2_vtflt)
//
in (* in-of-local *)
//
val () =
the_sortenv_padd($SYM.INT_symbol, s2tx_int)
val () =
the_sortenv_padd($SYM.ADDR_symbol, s2tx_addr)
val () =
the_sortenv_padd($SYM.BOOL_symbol, s2tx_bool)
val () =
the_sortenv_padd($SYM.CHAR_symbol, s2tx_char)
//
val () =
the_sortenv_padd($SYM.PROP_symbol, s2tx_prop)
val () =
the_sortenv_padd($SYM.VIEW_symbol, s2tx_view)
//
val () =
the_sortenv_padd($SYM.TBOX_symbol, s2tx_tbox)
val () =
the_sortenv_padd($SYM.TFLT_symbol, s2tx_tflt)
val () =
the_sortenv_padd($SYM.TYPE_symbol, s2tx_tflt)
//
val () =
the_sortenv_padd($SYM.VTBOX_symbol, s2tx_vtbox)
val () =
the_sortenv_padd($SYM.VTFLT_symbol, s2tx_vtflt)
val () =
the_sortenv_padd($SYM.VTYPE_symbol, s2tx_vtflt)
//
end // end of [local]

(* ****** ****** *)

(* end of [xats_trans12_envmap.dats] *)
