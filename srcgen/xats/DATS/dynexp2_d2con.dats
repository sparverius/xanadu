(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Xanadu - Unleashing the Potential of Types!
** Copyright (C) 2020 Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: March, 2020
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
#staload "./../SATS/stamp0.sats"
//
#staload "./../SATS/symbol.sats"
#staload "./../SATS/lexing.sats"
//
#staload "./../SATS/trans01.sats"
//
#staload "./../SATS/staexp2.sats"
#staload "./../SATS/statyp2.sats"
#staload "./../SATS/dynexp2.sats"
//
(* ****** ****** *)

#define ND2CON 1*1024

(* ****** ****** *)

local

absimpl
d2con_tbox = $rec{
//
  d2con_loc= loc_t // loc
, d2con_sym= sym_t // name
, d2con_sexp= s2exp // sexp
, d2con_type= t2ype // type
, d2con_stamp= stamp // unicity
//
} (* end of [d2con_tbox] *)

in (* in-of-local *)

implement
d2con_make_idtp
  (tok, s2e1) =
(
$rec{
  d2con_loc= loc
, d2con_sym= sym
, d2con_sexp= s2e1
, d2con_type= t2p2
, d2con_stamp= stamp
}
) where
{
  val loc = tok.loc()
  val sym = dexpid_sym(tok)
//
  val t2p2 = s2exp_erase(s2e1)
//
  val
  stamp = d2con_stamp_new((*void*))
//
(*
  val () =
  println!("d2con_make_idtp: sym = ", sym)
  val () =
  println!("d2con_make_idtp: s2e1 = ", s2e1)
  val () =
  println!("d2con_make_idtp: t2p2 = ", t2p2)
  val () =
  println!("d2con_make_idtp: stamp = ", stamp)
*)
//
} (* d2con_make_idtp *)

implement
d2con_get_loc(x0) = x0.d2con_loc
implement
d2con_get_sym(x0) = x0.d2con_sym
implement
d2con_get_sexp(x0) = x0.d2con_sexp
implement
d2con_get_type(x0) = x0.d2con_type
implement
d2con_get_stamp(x0) = x0.d2con_stamp

end // end of [local]

(* ****** ****** *)

(* end of [xats_dynexp2_d2con.dats] *)
