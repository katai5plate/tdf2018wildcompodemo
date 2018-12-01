PrintWriter log;
int w = 0;
class Star {
  float px, py, vx, vy, s, a;
  Star(int t) {
    reset(t,false);
  }
  void reset(int i,boolean x) {
    vx=random(-1, 1);
    vy=random(-1, 1);
    float r = random(0,width+height);
    px=width/2+vx*r;
    py=height/2+vy*r;
    //pic I,N,0,VX,VY,0,S,1,A,A,R,G,B,V,M,E
    if(i!=0){
      //if(x==false){
        String[] o = {"pic",(i)+",\"star\",0,",int(width/2)+",",int(height/2)+",0,",3+",1,",100+",",100+",","100,100,100,0,0,0"};
        log.println(join(o," "));
      //}else{
      //  String[] o = {"picmove",(i)+",0,",int(px)+",",int(py)+",",3+",",100+",",100+",",int(0)+",","0,100,100,100,0,0,0"};
      //  log.println(join(o," "));
      //}
    }
  }
  void draw(int i) {
    px+=vx*2;
    py+=vy*2;
    
    s = dist(px,py,width/2,height/2)/10;
    a = height-dist(px,py,width/2,height/2);
    
    fill(a);
    if (px<0||px>width||py<0||py>height) reset(i,true);
    else{ ellipse(px, py, s, s); }
    
    if(i!=0){
      String[] o = {"picmove",(i)+",0,",int(px)+",",int(py)+",",int(s<3?3:s)+",",int(a/255*100)+",",int(a/255*100)+",",int(w)+",","0,100,100,100,0,0,0"};
      log.println(join(o," "));
    }
  }
}
 
ArrayList<Star> stars = new ArrayList();
 
void setup() {
  size(320, 240);
  stroke(255);
  background(0);
  noStroke();
  ellipseMode(CENTER);
  log = createWriter("space_log.hsp");
  log.write("#include \"rpgfunc.as\":");
  for(int i=0;i<30;stars.add(new Star(i++)));
}
 
void draw() {
  if(!mousePressed) background(0);
  for(int i=0;i<stars.size();stars.get(i++).draw(i));
  log.println("pause "+int(w));
  println(frameCount);
  if(frameCount==60*6)finish(); //6 seconds
}

void finish() {
  log.println("send");
  log.flush();
  log.close();
  exit(); 
}
