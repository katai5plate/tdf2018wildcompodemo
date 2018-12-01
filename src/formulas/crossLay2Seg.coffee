# COUTION! This code is unverified. #
# refs: https://github.com/ncase/sight-and-light/blob/gh-pages/draft1.html #

let ray_ax,ray_ay,ray_bx,ray_by 0 in ray;
let seg_ax,seg_ay,seg_bx,seg_by 0 in segment line;
let res 1 out;
let res_x,res_y,res_p 0 out;

let rpx ray_ax;
let rpy ray_ay;
let rdx ray_bx; 
let rdy ray_by;
let spx seg_ax;
let spy seg_ay;
let sdx seg_bx; 
let sdy seg_by;

let rmag,smag,rmag_tx,rmag_ty,smag_tx,smag_ty 0;

let samea,sameb 0;

let t1,t2,tta,ttb,ttc 0;

let sqrt_in,sqrt_res,sqrt_p,sqrt_pf,sqrt_t 0;

rdx - rpx;
rdy - rpy;
sdx - spx;
sdy - spy;

rmag_tx = rdx * rdx; rmag_ty = rdy * rdy;

sqrt_in = rmag_tx + rmag_ty;
sqrt_res,sqrt_p,sqrt_pf = 0; sqrt_t = sqrt_in;
loop;
  sqrt_res = sqrt_in / sqrt_t + sqrt_t / 2;
  if sqrt_res ! sqrt_p;
    if sqrt_pf = 1;
      sqrt_p = sqrt_res;
    if.end;
    sqrt_t = sqrt_res;
  if.else;
    loop.break;
  if.end;
loop.end;
sqrt_res + sqrt_t / 2; rmag = sqrt_res;

smag_tx = sdx * sdx; smag_ty = sdy * sdy;

sqrt_in = smag_tx + smag_ty;
sqrt_res,sqrt_p,sqrt_pf = 0; sqrt_t = sqrt_in;
loop;
  sqrt_res = sqrt_in / sqrt_t + sqrt_t / 2;
  if sqrt_res ! sqrt_p;
    if sqrt_pf = 1;
      sqrt_p = sqrt_res;
    if.end;
    sqrt_t = sqrt_res;
  if.else;
    loop.break;
  if.end;
loop.end;
sqrt_res + sqrt_t / 2; smag = sqrt_res;

samea = rdx / rmag; sameb = sdx/smag;
if samea = sameb;
  samea = rdy / rmag; sameb = sdy/smag;
  if samea = sameb;
    res = 0;
  if.end;
if.end;

tta = rdx; ttb = spy - rpy; tta * ttb;
ttb = rdy; ttc = rpx - spx; ttb * ttc; tta + ttb;
ttb = sdx * rdy; ttc = sdy * rdx; ttb - ttc;
t2 = tta / ttb;

tta = sdx * t2;
t1 = spx + tta - rpx;

if t1 < 0;
  res = 0;
if.end;
if t2 < 0;
  res = 0;
if.end;
if t2 > 1;
  res = 0;
if.end;

if res = 1;
  res_x = rdx * t1 + rpx;
  res_y = rdy * t1 + rpy;
  res_p = t1;
if.end;
