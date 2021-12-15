import gifAnimation.*;

Mario mario = new Mario();
Gif marioReposo;

Gif marioAndando;
PVector velocityAnda;

Gif marioRetrocediendo;
PVector velocityRetrocede;

Gif marioSaltando;
PVector location;  // Location of shape
PVector velocitySube;
PVector gravity;   // Gravity acts at the shape's acceleration
boolean sube;

void setup(){
  size(636,360);
  frameRate(60);
  
  marioReposo = new Gif(this,"marioReposo-2.gif");
  marioReposo.play();
  
  marioAndando = new Gif(this,"marioAndando.gif");
  marioAndando.play();
  velocityAnda = new PVector(3,0);
  
  marioRetrocediendo = new Gif(this,"marioRetrocediendo.gif");
  marioRetrocediendo.play();
  velocityRetrocede = new PVector(-3,0);
  
  marioSaltando = new Gif(this,"marioSaltando.gif");
  marioSaltando.play();
  location = new PVector(0,200);
  velocitySube = new PVector(1.5,-9.1);
  gravity = new PVector(0,0.4);
  sube = false;
  
}


PImage fondo;
boolean ya = true;

void draw(){
  //frameCount = frameCount%60;
  fondo = loadImage("fondo.jpg");
  image(fondo,0,0);
  if(frameCount == 1){
    mario.start();
  }

  
  if(keyPressed){
    if(keyCode == RIGHT){
      image(marioAndando,location.x,location.y);
      location.add(velocityAnda);
    }
    if(keyCode == LEFT){
      image(marioRetrocediendo,location.x,location.y);
      location.add(velocityRetrocede);
    }
    if(keyCode == UP){
      if(!sube){
        marioSaltando.jump(0);
      }
      sube = true;
      if(sube){
        image(marioSaltando,location.x,location.y);
        location.add(velocitySube);
        velocitySube.add(gravity); 
        if (location.y > 200) {
          velocitySube.x = 0;
          location.y = 200;
          sube = false;
          velocitySube = new PVector(1.5,-9.1);
        }
      }
    }
  }
  else{
    if(sube){
      image(marioSaltando,location.x,location.y);
      location.add(velocitySube);
      velocitySube.add(gravity); 
      if (location.y > 200) {
        velocitySube.x = 0;
        location.y = 200;
        sube = false;
        velocitySube = new PVector(1.5,-9.1);
      }
    }
    else{
    image(marioReposo,location.x+15,location.y);
    }
  }
  
}
public void cambia(int estado){
  if(estado == 0){
    marioReposo = new Gif(this,"marioReposo-2.gif");
    marioReposo.play();
  }
  if(estado == 1){
    marioReposo = new Gif(this,"marioAndando.gif");
    marioReposo.play();
  }
}
class Mario{
  int posicionX;
  int posicionY;
  void start(){
    posicionX=0;
    posicionY=200;
  }
  void anda(){
    posicionX+=3;
  }
  void retrocede(){
    posicionX-=3;
  }

}
