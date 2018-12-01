const points = [
  {x:50, y:50, z:0},
  {x:100, y:50, z:0},
  {x:50, y:100, z:0},
  {x:100, y:100, z:0},
  {x:50, y:50, z:50},
  {x:100, y:50, z:50},
  {x:50, y:100, z:50},
  {x:100, y:100, z:50},
]

const setup = () => {
  for(let i in points){
    picture.show(i, "test", points[i].x, points[i].y);
  }
  return 60;
}
const draw = () => {
  const f = fc * 180 / 3.14;
  for(let i in points){
    let m = matrix(
      points[i].x,points[i].y,points[i].z,
      1,0,0,0,
      0,Math.cos(f),-Math.sin(f),0,
      0,Math.sin(f),Math.cos(f),0
    );
    [points[i].x,points[i].y] = [m.x,m.y]
    picture.show(i, "test", points[i].x, points[i].y);
  }
}

const matrix = (x, y, z, a, b, c, d, e, f, g, h, i, j, k, l) => {
  return {
    x: (x * a) + (y * b) + (z * c) + d,
    y: (x * e) + (y * f) + (z * g) + h,
    z: (x * i) + (y * j) + (z * k) + l
  }
}