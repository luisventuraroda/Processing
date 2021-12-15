import gifAnimation.*;

//Mario mario = new Mario();
Gif marioReposo;

Gif marioAndando;
PVector velocityAnda;

Gif marioRetrocediendo;
PVector velocityRetrocede;

Gif marioSaltando;
PVector location;  // Location of shape
PVector velocitySube;
PVector velocitySubeDerecha;
PVector velocitySubeIzquierda;
PVector gravity;   // Gravity acts at the shape's acceleration
boolean sube;

ArrayList<Integer> keyCodesPulsados = new ArrayList<Integer>();

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
  velocitySube = new PVector(0,-9.1);
  velocitySubeDerecha = new PVector(1.5,-9.1);
  velocitySubeIzquierda = new PVector(-1.5,-9.1);
  gravity = new PVector(0,0.4);
  sube = false;
  
}

void keyPressed(){
  if(keyCode == LEFT || keyCode == RIGHT || keyCode == UP ){
    if (!keyCodesPulsados.contains(keyCode)){
      keyCodesPulsados.add(0,keyCode);
    }
  }
}

void keyReleased(){
  if (keyCodesPulsados.contains(keyCode)){
    keyCodesPulsados.remove(keyCodesPulsados.indexOf(keyCode));
  }
}

PImage fondo;
boolean ya = true;

void draw(){
  //frameCount = frameCount%60;
  fondo = loadImage("fondo.jpg");
  image(fondo,0,0);
  /*
  if(frameCount == 1){
    mario.start();
  }
  */

  
  if(keyCodesPulsados.size() > 0 && !sube){
    println(keyCode);
    int keyPulsada = keyCodesPulsados.get(0);
    if(keyPulsada == RIGHT && !sube){
      image(marioAndando,location.x,location.y);
      location.add(velocityAnda);
    }
    if(keyPulsada == LEFT && !sube){
      image(marioRetrocediendo,location.x,location.y);
      location.add(velocityRetrocede);
    }
    if(keyPulsada == UP){
      if(!sube){
        marioSaltando.jump(0);
      }
      sube = true;
      salta();
    }
    else{
      salta();
    }
  }
  else{
    salta();
  }
}
public void salta(){
  if(sube){
    print("HOLA");
    image(marioSaltando,location.x,location.y);
    location.add(velocitySube);
    if(keyCodesPulsados.contains(RIGHT)){
      location.add(velocityAnda);
    }else if(keyCodesPulsados.contains(LEFT)){
      location.add(velocityRetrocede);
    }
    velocitySube.add(gravity);
    if (location.y > 200) {
      //velocitySube.x = 0;
      location.y = 200;
      sube = false;
      velocitySube = new PVector(0,-9.1);
      velocitySubeDerecha = new PVector(1.5,-9.1);
      velocitySubeIzquierda = new PVector(-1.5,-9.1);
    }
  }else if(!keyCodesPulsados.contains(LEFT)&&!keyCodesPulsados.contains(RIGHT)){
      image(marioReposo,location.x+15,location.y);
  }
}
/*
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
*/
