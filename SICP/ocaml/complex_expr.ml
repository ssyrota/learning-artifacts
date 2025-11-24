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

let rec _newton_sqrt (y:float) (x:float) = 
  if abs((x -. y *. y)) < (x *. 0.001) then y 
  else _newton_sqrt (0.5 *. (y +. x/.y)) x
  

let () = 
  let result = _newton_sqrt 1. 0.04 in
  Printf.printf "sqrt = %f\n" result