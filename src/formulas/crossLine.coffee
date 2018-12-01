# COUTION! This code is unverified. #
# ref: https://qiita.com/ykob/items/ab7f30c43a0ed52d16f2 #

let ax,ay,bx,by 0 in Line_1;
let cx,cy,dx,dy 0 in Line_2;
let res 0 out;

let ta,tb,tc,td,t 0;
let w,x,y,z 0;

w = cx - dx; x = ay - cy; y = cy - dy; z = cx - ax;
t = w * x; ta = y * z + t;

w = cx - dx; x = by - cy; y = cy - dy; z = cx - bx;
t = w * x; tb = y * z + t;

w = ax - bx; x = cy - ay; y = ay - by; z = ax - cx;
t = w * x; tc = y * z + t;

w = ax - bx; x = dy - ay; y = ay - by; z = ax - dx;
t = w * x; tc = y * z + t;

w = tc * td;
x = ta * tb;
if w < 0;
  if x < 0;
    res = 1;
  if.end
if.end;
