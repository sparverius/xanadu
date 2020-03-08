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
// For generic basics
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Start Time: June, 2019
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)

fun
<a:vtype>
g_self(x: a): a

(* ****** ****** *)

fun
<a:vtype>
g_free(x: a): void
fun
<a:vtype>
g_copy(x: !(a)): (a)

(* ****** ****** *)

fun
<a:vtype>
g_print(x: !(a)): void

(* ****** ****** *)

fun
<a:vtype>
g_equal(!a, !a): void
fun
<a:vtype>
g_nequal(!a, !a): void

(* ****** ****** *)

fun
<x0:t0><y0:vt>
map$fopr(x0: x0): (y0)
fun
<x0:vt><y0:vt>
map0$fopr(x0: x0): (y0)
fun
<x0:vt><y0:vt>
map1$fopr(x0: !x0): (y0)

(* ****** ****** *)

fun
<x0:t0>
filter$test(x0: x0): bool
fun
<x0:vt>
filter0$test(x0: x0): bool
fun
<x0:vt>
filter1$test(x0: !x0): bool

(* ****** ****** *)
//
// HX-2020-03-05:
// Using filter + map together
//
fun
<x0:t0><y0:vt>
mapopt$fopr(x0): optn_vt(y0)
fun
<x0:vt><y0:vt>
mapopt0$fopr(x0): optn_vt(y0)
fun
<x0:vt><y0:vt>
mapopt1$fopr(x0: !x0): optn_vt(y0)
//
(* ****** ****** *)

fun
<x0:t0>
forall$test(x0: x0): bool
fun
<x0:vt>
forall0$test(x0: x0): bool
fun
<x0:vt>
forall1$test(x0: !x0): bool

(* ****** ****** *)

fun
<x0:t0>
foreach$work(x0: x0): void
fun
<x0:vt>
foreach0$work(x0: x0): void
fun
<x0:vt>
foreach1$work(x0: !x0): void

(* ****** ****** *)
//
fun
<x0:t0>
<r0:vt>
foldl$fopr(r0: r0, x0: x0): r0
fun
<x0:t0>
<r0:vt>
foldr$fopr(x0: x0, r0: r0): r0
//
(* ****** ****** *)
//
fun
<a:vt>
<n:i0>
tabulate$fopr(i0: nintlt(n)): (a)
//
(* ****** ****** *)

fun
<x0:t0>
rforall$test(x0: x0): bool
fun
<x0:vt>
rforall0$test(x0: x0): bool
fun
<x0:vt>
rforall1$test(x0: !x0): bool

(* ****** ****** *)

fun
<x0:t0>
rforeach$work(x0: x0): void
fun
<x0:vt>
rforeach0$work(x0: x0): void
fun
<x0:vt>
rforeach1$work(x0: !x0): void

(* ****** ****** *)
//
// For gseq-i-operations
//
(* ****** ****** *)

fun
<x0:t0>
iforall$test(nint, x0): bool
fun
<x0:vt>
iforall0$test(nint, x0): void
fun
<x0:vt>
iforall1$test(nint, !x0): void

(* ****** ****** *)

fun
<x0:t0>
iforeach$work(nint, x0): void
fun
<x0:vt>
iforeach0$work(nint, x0): void
fun
<x0:vt>
iforeach1$work(nint, !x0): void

(* ****** ****** *)
//
// For 2-gseq-operations
//
(* ****** ****** *)
//
fun
<x0:t0
,y0:t0>
<r0:vt>
x2foldl$fopr(r0, x0, y0): r0
fun
<x0:t0
,y0:t0>
<r0:vt>
x2foldr$fopr(x0, y0, r0): r0
//
fun
<x0:t0
,y0:t0>
x2forall$test(x0, y0): bool
fun
<x0:t0
,y0:t0>
x2foreach$work(x0, y0): void
//
#symload
xfoldl$fopr with x2foldl$fopr
#symload
xfoldr$fopr with x2foldr$fopr
#symload
xforall$test with x2forall$test
#symload
xforeach$work with x2foreach$work
//
(* ****** ****** *)
//
fun
<x0:t0
,y0:t0>
<r0:vt>
z2foldl$fopr(r0, x0, y0): r0
fun
<x0:t0
,y0:t0>
<r0:vt>
z2foldr$fopr(x0, y0, r0): r0
//
fun
<x0:t0
,y0:t0>
z2forall$test(x0, y0): bool
fun
<x0:t0
,y0:t0>
z2foreach$work(x0, y0): void
//
#symload
zfoldl$fopr with z2foldl$fopr
#symload
zfoldr$fopr with z2foldr$fopr
#symload
zforall$test with z2forall$test
#symload
zforeach$work with z2foreach$work
//
(* ****** ****** *)

(* end of [gbas.sats] *)
