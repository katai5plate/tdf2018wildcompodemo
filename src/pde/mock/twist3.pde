PImage t;
void setup() {
  size(320, 240);
  t = loadImage("twist01.png");
  frameRate(30);
}
void draw() {
  background(0);
  int FC = frameCount%360;
  for (int y = 0; y < 15; ++y) {
    int offsetX = int(sin(radians(FC))*1000);
    int frameX = ((FC + y) % 10) * -320;
    image(t, frameX + offsetX, y * 16);
    
  }
  //println(int(sin(radians(FC))*1000));
  println(int(sin(radians(1))*1000));
}
