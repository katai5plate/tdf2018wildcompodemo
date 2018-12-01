# This code is for testing #

let deg 0 in;
let r 0 in;
let plus 0 in;
let cosFlug 0 in;

let res 0 out;

let temp 0;
let mark 1;

let backup_deg deg;

if cosFlug = 1;
  deg + 90;
if.end;

if deg < 0;
  deg * -1;
  mark * -1;
if.end;
if deg > 360;
  deg % 360;
if.end;
if deg > 270;
  deg - 360 * -1;
  mark * -1;
if.else;
  if deg > 180;
    deg - 180;
    mark * -1;
  if.else;
    if deg > 90;
      deg - 180 * -1;
    if.end;
  if.end;
if.end;

temp = deg * deg * 64 / 2025;
res = temp * -20 + 12000;
temp * temp / 100;
res + temp * deg / 6750 * mark;

res * r / 100 + plus;

deg = backup_deg;
