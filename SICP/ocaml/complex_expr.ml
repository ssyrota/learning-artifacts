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
let rec _newton_sqrt (y:float) (x:float) = 
  let good_enough = () => abs((x -. y *. y)) < (x *. 0.001) in
    if good_enough then y 
    else _newton_sqrt (0.5 *. (y +. x/.y)) x


let rec _newton_cube_root (y:float) (x:float) = 
  let _ = Printf.printf "diff = %f\nepsilon = %f\n" (abs(x -. ((y *. y) *. y))) (x /. 1000.) in
    if abs(x -. ((y *. y) *. y)) < (x /. 1000.) then y 
      else _newton_cube_root ((x /. (y *.y) +. 2. *. y) /. 3.) x

let () = 
  Printf.printf "cube root = %f\n" (_newton_cube_root 1. 0.008)