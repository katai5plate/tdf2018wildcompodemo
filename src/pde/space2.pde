PrintWriter log;
int wait = 0;
int waitRepeat = 2;
int count = 30;
int seconds = 12; 
String name = "star";

float[] x = new float[30];
float[] y = new float[30];
float[] s = new float[30];
float[] a = new float[30];
float[] c = new float[30];
float[] vx = new float[30];
float[] vy = new float[30];

void setup(){
  log = createWriter("space_log.hsp");
  log.write("#include \"rpgfunc.as\":");
  size(320,240);
  for(int i=0;i<count;i++){
    reset(i);
  }
  noStroke();
}
void draw(){
  background(0);
  fill(255);
  for(int i=0;i<count;i++){
    if(x[i]<0||width<x[i]){
      reset(i);
    }else{
      x[i]+=vx[i];
    }
    if(y[i]<0||height<y[i]){
      reset(i);
    }else{
      y[i]+=vy[i];
    }
    s[i] = dis(i)*50;
    s[i] = s[i]<0 ? 3 : s[i];
    a[i] = 127+(dis(i)*127);
    c[i] = dis(i)*255;
    log.println(pic(i,"move"));
  }
  for(int r=0; r < waitRepeat; r ++) log.println("pause "+wait);
  if(frameCount==60*seconds) finish();
}
void reset(int i){
  x[i]=(width/2)+vx[i];
  y[i]=(height/2)+vy[i];
  vx[i]=sin(radians(random(360)))*random(-5,5);
  vy[i]=sin(radians(random(360)))*random(-5,5);
  s[i]=3;
  a[i]=0;
  c[i]=255;
  log.println(pic(i,"show"));
}
void finish() {
  log.println("send");
  log.flush();
  log.close();
  exit(); 
}
String picShow(int id,int _x,int _y, int _s, int _a, int _c){
  String[] script = {"pic ",str(id+1),",\"",name,"\",0,",str(_x),",",str(_y),",0,",str(_s),",1,",str(_a),",,",str(_c)+","+str(_c)+","+str(_c)+","+str(_c)+",0,0"};
  return join(script, "");
}
String picMove(int id,int _x,int _y, int _s, int _a, int _c){
  String[] script = {"picmove ",str(id+1),",0,",str(_x),",",str(_y),",",str(_s),",",str(_a),",,",str(wait),",0,",str(_c)+","+str(_c)+","+str(_c)+","+str(_c)+",0,5"};
  return join(script, "");
}
String pic(int id, String mode){
  float _x = x[id];
  float _y = y[id];
  float _s = s[id];
  float _a = a[id];
  float _c = c[id];
  fill(_c,_a);
  ellipse(_x,_y,_s,_s);
  int ix = int(_x);
  int iy = int(_y);
  int is = _s<3 ? 3 : int(_s);
  int ia = 100-int(_a/255*100);
  int ic = int(_a/255*100);
  String res = ":";
  if(mode=="show"){
    res = picShow(id, ix, iy, is, ia, ic);
  }else if(mode=="move"){
    res = picMove(id, ix, iy, is, ia, ic);
  }
  return res;
}
float dis(int id){
  float range = dist(width,height,width/2,height/2);
  float temp = dist(x[id],y[id],width/2,height/2);
  return temp/range;
}
