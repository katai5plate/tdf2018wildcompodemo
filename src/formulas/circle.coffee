let deg 0 in angle degree;
let r 0 in redius;
let offsetX,offsetY 0 in center;
let mulX,mulY 100 in zoom per;

let resX,resY 0 out position;

let res,temp 0;
let mark 1;
let backup_deg deg;

>>> sin wave;

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

resX = res * r / 100;

>>> reset;

deg = backup_deg + 90;
res,temp = 0;
mark = 1;

>>> cos wave;

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

resY = res * r / 100;

>>> offset;

resX * mulX / 100 + offsetX;
resY * mulY / 100 + offsetY;

deg = backup_deg;
