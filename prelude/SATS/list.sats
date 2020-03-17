(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Xanadu - Unleashing the Potential of Types!
** Copyright (C) 2019 Hongwei Xi, ATS Trustful Software, Inc.
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
// For functional lists
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Start Time: September, 2019
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
fun<>
list_nilq
{a:type}{n:int}
(xs: list(a, n)): bool(n = 0)
fun<>
list_consq
{a:type}{n:int}
(xs: list(a, n)): bool(n > 0)
//
#symload eqzq with list_nilq
#symload neqzq with list_consq
//
(* ****** ****** *)
//
fun
<a:type>
list_head
{i:pos}(list(a, i)): a
fun
<a:type>
list_head_raw(xs: list(a)): a
fun
<a:type>
list_head_exn(xs: list(a)): a
fun
<a:type>
list_head_opt(xs: list(a)): opt_vt(a)
//
fun
<a:type>
list_tail
{i:pos}(list(a, i)): list(a, i-1)
fun
<a:type>
list_tail_raw(xs: list(a)): list(a)
fun
<a:type>
list_tail_exn(xs: list(a)): list(a)
fun
<a:type>
list_tail_opt(xs: list(a)): opt_vt(list(a))
//
(* ****** ****** *)
//
fun
<a:type>
list_length
{n:int}(xs: list(a, n)): int(n)
//
#symload length with list_length
//
(* ****** ****** *)
//
fun
<a:type>
list_append
{m,n:int}
( xs: list(a, m)
, ys: list(a, n)): list(a, m+n)
//
#symload append with list_append
//
(* ****** ****** *)
//
fun
<a:type>
list_rappend
{m,n:int}
( xs: list(a, m)
, ys: list(a, n)): list(a, m+n)
//
#symload rappend with list_rappend
//
(* ****** ****** *)
//
fun
<a:type>
list_reverse
{n:int}(list(a, n)): list(a, n)
//
#symload reverse with list_reverse
//
(* ****** ****** *)
//
fun
<a:type>
list_copy_vt
{n:int}(list(a, n)): list_vt(a, n)
fun
<a:type>
list_rcopy_vt
{n:int}(list(a, n)): list_vt(a, n)
//
#symload copy_vt with list_copy_vt
#symload rcopy_vt with list_rcopy_vt
//
(* ****** ****** *)

fun
<x0:type>
list_forall
{n:int}(xs: list(x0, n)): bool
fun
<x0:type>
list_foreach
{n:int}(xs: list(x0, n)): void

(* ****** ****** *)
//
(*
list_map: map$for
list_map_vt: map$for
*)
//
fun
<x0:type>
<y0:type>
list_map
{n:int}(xs: list(x0, n)): list(y0, n)
fun
<x0:type>
<y0:vtype>
list_map_vt
{n:int}(xs: list(x0, n)): list_vt(y0, n)
//
(* ****** ****** *)
//
(*
list_maprev: map$for
list_maprev_vt: map$for
*)
//
fun
<x0:type>
<y0:type>
list_maprev
{n:int}(xs: list(x0, n)): list(y0, n)
fun
<x0:type>
<y0:vtype>
list_maprev_vt
{n:int}(xs: list(x0, n)): list_vt(y0, n)
//
(* ****** ****** *)
//
fun
<a:t0>
<n:i0>
list_tabulate(int(n)): list(a, n)
fun
<a:type>
list_tabulate_cref
{n:nat}
( n0: int(n)
, f0: nintlt(n) -<cref> a): list(a, n)
//
(* ****** ****** *)

(* end of [list.sats] *)
