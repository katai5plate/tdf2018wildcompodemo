# COUTION! This code is unverified. #

# | x 0 0 0 | #
# | y 0 0 0 | #
# | z 0 0 0 | #
# | 1 0 0 0 | #
let x,y,z 123 in vector;

# | a b c d | #
# | e f g h | #
# | i j k l | #
# | 0 0 0 1 | #
let a 1 in matrix_line_1 | 1 _ _ _ |;
let b 0 in matrix_line_1 | x 0 _ _ |;
let c 0 in matrix_line_1 | x _ 0 _ |;
let d 0 in matrix_line_1 | x _ _ 0 |;
let e 0 in matrix_line_2 | 0 _ _ _ |;
let f 1 in matrix_line_2 | y 1 _ _ |;
let g 0 in matrix_line_2 | y _ 0 _ |;
let h 0 in matrix_line_2 | y _ _ 0 |;
let i 0 in matrix_line_3 | 0 _ _ _ |;
let j 0 in matrix_line_3 | z 0 _ _ |;
let k 1 in matrix_line_3 | z _ 1 _ |;
let l 0 in matrix_line_3 | z _ _ 0 |;

# ex. Move: d = X, h = Y, l = Z #
# ex. Zoom: a = X, f = Y, k = Z #
# ex. RotX: f = cos , g = -sin , j =  sin , k = cos #
# ex. RotY: a = cos , c =  sin , i = -sin , k = cos #
# ex. RotZ: a = cos , b = -sin , e =  sin , f = cos #

let rx,ry,rz 0 out result vector;

let t 0;

t = x * a; rx = t;
t = y * b; rx + t;
t = z * c; rx + t + d;

t = x * e; ry = t;
t = y * f; ry + t;
t = z * g; ry + t + h;

t = x * i; rz = t;
t = y * j; rz + t;
t = z * k; rz + t + l;
