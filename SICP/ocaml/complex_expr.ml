(*
(* using prefix form *)
div (sum 5 (sum 4 (sub 2 (sub 3 (sum 6 (div 4 5)))))) (2)

(* or *)

let a = sum 6 (div 4 5) in
  let b = sub 3 a in
  let c = sub 2 b in
  let d = sum 5 (sum 4 c) in
d;;
*)

let abs (x:float) = if x < 0. then -.x else x

(* sqrt actually depends on `abs` free variable, while having `bound variables` y and x *)
let rec newton_sqrt (y:float) (x:float) = 
  (* ocaml supports block structure to manage lexical scope *)
  let good_enough = abs((x -. y *. y)) < (x *. 0.001) in
    if good_enough then y 
    else newton_sqrt (0.5 *. (y +. x/.y)) x


let rec newton_cube_root (y:float) (x:float) = 
  let _ = Printf.printf "diff = %f\nepsilon = %f\n" (abs(x -. ((y *. y) *. y))) (x /. 1000.) in
    if abs(x -. ((y *. y) *. y)) < (x /. 1000.) then y 
      else newton_cube_root ((x /. (y *.y) +. 2. *. y) /. 3.) x


(* 
  linear recursive process, the execution requires maintaining stack for each nested function call
  The expansion occurs as the process builds up a chain of
  deferred operations (in this case, a chain of multiplications)
*)
let rec factorial_r n = if n=1 then 1 else n*factorial_r(n-1)

(* 
linear iterative process
The variables provide a complete description of the state of the process at any point.
If we stop at some point and list variables, we can continue later.
If we stop recursive process - there is some "hidden" info of deferred operations, which cannot be dumped.

Ocaml should execute an iterative process in constant space, this property is called tail-recursive.
*)
let factorial_i n = 
  let rec factorial_iter product counter max = 
      if counter > max then product else factorial_iter (counter*product) (counter+1) max
    in
  factorial_iter 1 1 n

let () = 
  Printf.printf "cube root = %f\n" (newton_cube_root 1. 0.008)


(*
recursion task
1. 2y
2. just 2^y
---
2 * (A 1 (n - 1))

(A 1 (n - 1)) = 2 * (A 1 (n - 2))
...
(A 1 (n - M)) = 2 * (A 1 (n - M+1))
until y = 0

3. (A 2 n)

A 1 (A 2 (n -1))

2^y, where y = A 2 (n - 1)

if y = 2
y = A 2 1
2^(2)

if y = 3 
2^y, where y = A 2 2
looks like recursive ^
*)