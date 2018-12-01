/* @pjs preload="img/twist01.png"; */
PImage t;
void setup() {
  size(320, 240);
  t = loadImage("img/twist01.png");
  frameRate(10);
}
void draw() {
  background(0);
  for (int y = 0; y < 15; ++y) {
    image(t, -(((frameCount + y) % 10) * (320)), y * 16);
  }
}