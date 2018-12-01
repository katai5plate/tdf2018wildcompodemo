# COUTION! This code is unverified. #

let arg 0 in;
let res 0 out;

let pre,pref 0;
let temp arg;

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
