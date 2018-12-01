# COUTION! This code is unverified. #

let x1,y1 0 in from;
let x2,y2 0 in to;
let res 0 out distance;

let arg,temp,pre,pref 0;

>>> calc distance;

arg = x1 - x2 * arg;
temp = y1 - y2 * temp;
arg + temp;

>>> sqrt;

loop;
  res = arg / temp + temp / 2;
  if res ! pre;
    if pref = 1;
      pre = res;
    if.end;
    temp = res;
  if.else;
    loop.break;
  if.end;
loop.end;

res + temp / 2;
