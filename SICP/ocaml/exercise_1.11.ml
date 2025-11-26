let abs (x:float) = if x < 0. then -.x else x

(* recursive *)
let rec rec_f n = if n<3 then n 
  else (rec_f(n-1) + 2*rec_f(n-2) + 3*rec_f(n-3))

let rec iterative_f n = 
    if n < 3 then n else
    let rec step n counter a b c = 
        let new_c = b in
        let new_b = a in
        let new_a = a + 2*b + 3*c in
        if counter==n then new_a
        else step 
          n 
          (counter+1) 
          new_a
          new_b
          new_c
        in
    step n 
      3(*counter*)  
      2(*n-1 at start from 3*) 
      1(*n-2 at start from 3*) 
      0(*n-3 at start from 3*)
  
let () = 
  let _ = Printf.printf "rec_f 20 = %d\n" (rec_f 11) in
  Printf.printf "iterative_f 20 = %d\n" (iterative_f 11)
  
