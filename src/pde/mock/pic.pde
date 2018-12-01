/* @pjs preload="img/test.png"; */

Picture[] p = new Picture[50 + 1];

void pInit() {
  for (int i = 0; i < p.length; i++) {
    p[i] = new Picture;
  }
}
void pUpdate() {
  background();
  for (int i = 0; i < p.length; i++) {
    if (!!p[i].img) p[i].update();
  }
}

void setup() {
  size(320, 240);
  // frameRate(10);
  pInit();
  p[0].set("img/test.png", 0, 0, 100, 0);
  p[0].mov(320, 240, 100, 0, 60);
}
void draw() {
  pUpdate();
  // p[0].mov(mouseX, mouseY, mouseX, mouseY, 60);
}

class Picture {
  int x, y, s, a, index, wait,
  dx, dy, ds, da,
  tx, ty, ts, ta;
  PImage img;
  void set(String _name, int _x, int _y, int _s, int _a) {
    img = loadImage(_name);
    x = _x, y = _y, s = !!_s ? _s : s, a = !!_a ? _a : a;
  }
  void mov(int _x, int _y, int _s, int _a, int _w) {
    dx = x, dy = y, ds = s, da = a;
    tx = _x, ty = _y, ts = _s, ta = _a, wait = _w;
    index = 0;
  }
  void getSX() {
    return int(img.width * ds / 100);
  }
  void getSY() {
    return int(img.height * ds / 100);
  }
  void getX() {
    return int(dx - (getSX() / 2));
  }
  void getY() {
    return int(dy - (getSY() / 2));
  }
  void getA() {
    return int((100 - da) * 255 / 100);
  }
  void getD() {
    float d = index / wait;
    return d >= 1 ? 1 : d <= 0 ? 0 : d;
  }
  void update() {
    dx = lerp(x, tx, getD()), dy = lerp(y, ty, getD());
    ds = lerp(s, ts, getD()), da = lerp(a, ta, getD());
    index++;
    tint(255, getA());
    image(img, getX(), getY(), getSX(), getSY());
  }
}