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
// Start Time: September, 2019
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
#staload "./../SATS/label0.sats"
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
//
#staload "./../SATS/staexp2.sats"
#staload "./../SATS/statyp2.sats"
#staload "./../SATS/dynexp1.sats"
#staload "./../SATS/dynexp2.sats"
#staload "./../SATS/dynexp3.sats"
//
#staload "./../SATS/tread3t.sats"
//
(* ****** ****** *)

#staload
_(*TMP*) = "./../DATS/staexp2_print.dats"
#staload
_(*TMP*) = "./../DATS/statyp2_print.dats"
#staload
_(*TMP*) = "./../DATS/dynexp1_print.dats"
#staload
_(*TMP*) = "./../DATS/dynexp2_print.dats"
#staload
_(*TMP*) = "./../DATS/dynexp3_print.dats"

(* ****** ****** *)

local

static
fun//{}
the_trerr3tlst_get(): trerr3tlst
extern
fun//{}
the_trerr3tlst_set(trerr3tlst): void

implement
//{}(*tmp*)
trerr3t_add(xerr) = let
//
val
xerrs = the_trerr3tlst_get()
//
in
  the_trerr3tlst_set(list_cons(xerr, xerrs))
end // end of [trerr3t_add]

in (* in-of-local *)
//
local
//
val
the_trerr3tlst =
ref<trerr3tlst>(list_nil)
//
in(*in-of-local*)
implement
the_trerr3tlst_get() = the_trerr3tlst[]
implement
the_trerr3tlst_set(xs) = the_trerr3tlst[] := xs
end // end of [local]
//
implement
tread3t_main(d3cs) = let
//
(*
val () =
tread3t_d3eclist<>(d3cs)
*)
//
val
xerrs = the_trerr3tlst_get()
val
nxerr = list_length<trerr3t>(xerrs)
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
("\
tread3t_main: \
nxerr = ", nxerr)
//
val () =
if
(nxerr = 1)
then
prerrln!
("\
tread3t_main: \
there is one trerr3t-error!")
val () =
if
(nxerr > 1)
then
prerrln!
("\
tread3t_main: \
there are some trerr3t-errors!")
//
val () =
(
$raise(XATSOPT_TRERR3T_EXN(*void*))
) : void
//
} (* end of [then] *)
else
{
//
val () =
prerrln!
("\
tread3t_main: \
there are none of trerr3t-errors!")
//
} (* end of [else] *)
//
end // end of [tread3t_main]

end // end of [local]

(* ****** ****** *)

(* end of [xats_tread3t_dynexp.dats] *)
