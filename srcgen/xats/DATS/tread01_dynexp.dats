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
// Start Time: September, 2018
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
#staload "./../SATS/xerrory.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/locinfo.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/lexing.sats"
#staload "./../SATS/staexp1.sats"
#staload "./../SATS/dynexp1.sats"
//
#staload "./../SATS/tread01.sats"
//
(* ****** ****** *)

#staload
_(*TMP*) = "./../DATS/tread01_staexp.dats"

(* ****** ****** *)
//
implement
//{}(*tmp*)
tread01_d1pat(d1p0) = ()
//
implement
//{}(*tmp*)
tread01_d1patlst(d1ps) =
(
list_foreach<d1pat>(d1ps)
) where
{
implement(env)
list_foreach$fwork<d1pat><env>(d1p, env) = tread01_d1pat(d1p)
} (* end of [tread01_d1patlst] *)
//
(* ****** ****** *)
//
implement
//{}(*tmp*)
tread01_d1exp(d1e0) = ()
//
(* ****** ****** *)
//
implement
//{}(*tmp*)
tread01_d1expopt(opt0) =
(
case+ opt0 of
| None() => ()
| Some(d1e) => tread01_d1exp(d1e)
) (* end of [tread01_d1expopt] *)
//
implement
//{}(*tmp*)
tread01_d1explst(d1es) =
(
list_foreach<d1exp>(d1es)
) where
{
implement(env)
list_foreach$fwork<d1exp><env>(d1e, env) = tread01_d1exp(d1e)
} (* end of [tread01_d1explst] *)
//
(* ****** ****** *)

implement
//{}(*tmp*)
tread01_d1ecl(d1c0) = let
//
val loc0 = d1c0.loc((*void*))
//
(*
val () =
println!
("tread01_d1ecl: d1c0 = ", d1c0)
*)
//
in
//
case+
d1c0.node() of
//
| D1Cfundecl
  ( knd
  , mopt
  , tqas, f1ds) =>
  {
    val () =
    tread01_f1undeclist(f1ds)
  }
//
| D1Cdynconst
  (knd, tqas, d1cs) =>
  {
    val () = tread01_tq1arglst(tqas)
(*
    val () = tread01_d1cstdeclist(d1cs)
*)
  }
//
| _(* rest-of-d1ecl *) =>
  (
    prerrln!(loc0, ": tread01_d1ecl: d1c0 = ", d1c0)
  )
//
end // end of [tread01_d1ecl]

(* ****** ****** *)
//
implement
//{}(*tmp*)
tread01_d1eclist(d1cs) =
(
list_foreach<d1ecl>(d1cs)
) where
{
implement(env)
list_foreach$fwork<d1ecl><env>(d1c, env) = tread01_d1ecl(d1c)
} (* end of [tread01_d1eclist] *)
//
(* ****** ****** *)

implement
//{}(*tmp*)
tread01_wths1expopt
  (opt0) =
(
case+ opt0 of
| WTHS1EXPnone() => ()
| WTHS1EXPsome(tok, s1e) => tread01_s1exp(s1e)
)

(* ****** ****** *)
//
implement
//{}(*tmp*)
tread01_f1arg(f1a0) =
(
case+
f1a0.node() of
| F1ARGsome_dyn(d1p0) => tread01_d1pat(d1p0)
| F1ARGsome_sta(s1qs) => tread01_s1qualst(s1qs)
| F1ARGsome_met(s1es) => tread01_s1explst(s1es)
) (* end of [tread01_f1arg] *)
//
implement
//{}(*tmp*)
tread01_f1arglst(f1as) =
(
list_foreach<f1arg>(f1as)
) where
{
implement(env)
list_foreach$fwork<f1arg><env>(f1a, env) = tread01_f1arg(f1a)
} (* end of [tread01_f1arglst] *)
//
(* ****** ****** *)
//
implement
//{}(*tmp*)
tread01_q1arg(q1a0) =
(
case+
q1a0.node() of
(*
| Q1ARGnone(tok) => ()
*)
| Q1ARGsome(sid, opt) =>
  {
    val () = tread01_sort1opt(opt)
  }
)
//
implement
//{}(*tmp*)
tread01_q1arglst(q1as) =
(
list_foreach<q1arg>(q1as)
) where
{
implement(env)
list_foreach$fwork<q1arg><env>(q1a, env) = tread01_q1arg(q1a)
} (* end of [tread01_tq1arglst] *)
//
(* ****** ****** *)
//
implement
//{}(*tmp*)
tread01_tq1arg(tq1a) =
(
case+
tq1a.node() of
| TQ1ARGnone(tok) => ()
| TQ1ARGsome(q1as) => tread01_q1arglst(q1as)
)
//
implement
//{}(*tmp*)
tread01_tq1arglst(tqas) =
(
list_foreach<tq1arg>(tqas)
) where
{
implement(env)
list_foreach$fwork<tq1arg><env>(tqa, env) = tread01_tq1arg(tqa)
} (* end of [tread01_tq1arglst] *)
//
(* ****** ****** *)
//
implement
//{}(*tmp*)
tread01_f1undecl
  (f1d0) =
{
  val () =
  tread01_d1expopt(rcd.def)
  val () =
  tread01_f1arglst(rcd.arg)
  val () =
  tread01_wths1expopt(rcd.wtp)
} where
{
//
  val+F1UNDECL(rcd) = f1d0
//
} (* end of [tread01_f1undecl] *)
//
implement
//{}(*tmp*)
tread01_f1undeclist(f1ds) =
(
list_foreach<f1undecl>(f1ds)
) where
{
implement(env)
list_foreach$fwork<f1undecl><env>(f1ds, env) = tread01_f1undecl(f1ds)
} (* end of [tread01_f1undeclist] *)
//
(* ****** ****** *)

local

static
fun//{}
the_trerr01lst_get(): trerr01lst
extern
fun//{}
the_trerr01lst_set(trerr01lst): void

implement
//{}(*tmp*)
trerr01_add(xerr) = let
//
val
xerrs = the_trerr01lst_get()
//
in
  the_trerr01lst_set(list_cons(xerr, xerrs))
end // end of [trerr01_add]

in (* in-of-local *)
//
local
//
val
the_trerr01lst =
ref<trerr01lst>(list_nil)
//
in(*in-of-local*)
implement
the_trerr01lst_get() = the_trerr01lst[]
implement
the_trerr01lst_set(xs) = the_trerr01lst[] := xs
end // end of [local]
//
implement
tread01_main(d1cs) = let
//
val () =
tread01_d1eclist(d1cs)
val
xerrs = the_trerr01lst_get()
val
nxerr = list_length<trerr01>(xerrs)
//
in
//
if
(nxerr > 0)
then
{
//
val () =
prerrln!
("tread01_main: nxerr = ", nxerr)
//
val () =
if
(nxerr = 1)
then
prerrln!
("\
tread01_main: \
there is one trans01-error!")
val () =
if
(nxerr > 1)
then
prerrln!
("\
tread01_main: \
there are some trans01-errors!")
//
val () =
(
$raise(XATSOPT_TRERR01_EXN(*void*))
) : void
//
} (* end of [then] *)
else
{
//
val () =
prerrln!
("\
tread01_main: \
there are none of trans01-errors!")
//
} (* end of [else] *)
//
end // end of [tread01_main]

end // end of [local]

(* ****** ****** *)

(* end of [xats_tread01_dynexp.dats] *)
