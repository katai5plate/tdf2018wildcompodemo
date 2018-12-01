/* @pjs preload="img/twist01.png"; */
PImage t;
void setup() {
  size(320, 240);
  t = loadImage("img/twist01.png");
  frameRate(30);
}
void draw() {
  background(0);
  for (int y = 0; y < 15; ++y) {
    int x = sin(radians(frameCount))*1000;
    image(t, -(((frameCount + y) % 10) * (320)) + x, y * 16);
  }
}