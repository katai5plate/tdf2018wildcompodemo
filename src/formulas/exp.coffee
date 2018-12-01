# COUTION! This code is unverified. #

# ex. e^8.2941 -> arg: 82941 #
let arg 0 in x10000;
# ex. res: 401152 -> 4011.52 '=. 4000.20  #
let res 0 out x100;

let roe,two 0;

loop;
  if arg >= 5000;
    arg - 5000;
    roe + 1;
  if.else;
    if arg <= -5000;
      arg + 5000;
      roe - 1;
    if.else;
      loop.break;
    if.end;
  if.end;
loop.end;

res = arg + 30500 / 1000 * arg + 605000 / 10000 * arg + 500 / 1000 + 600;

loop;
  if roe >= 1;
    if res >= 1555;
      res + 1 / 2;
      two + 1;
    if.end;
    res * 643 + 195 / 390;
    roe - 1;
  if.else;
    if roe <= -1;
      res * 390 + 322 / 643;
      roe + 1;
    if.else;
      loop.break;
    if.end;
  if.end;
loop.end;

if two = 1;
  res * 2;
  two - 1;
if.end;
if two >= 2;
  res * 4;
  two - 2;
if.end;
res + 3 / 6;

loop;
  if two <= 0;
    loop.break;
  if.end;
  res * 2;
  two - 1;
loop.end;
