Cat myCat;

void setup() {
  size(800,800);
  frameRate(60);
  textSize(15);
  myCat = new Cat(100,200,200);
}

void draw() {
    myCat.draw();
}
  
void keyPressed() {
  if (key == 'e' ) { //ROTATERIGHT
  myCat.turn("R",5);  
  }
  else if(key == 'q' ) { //ROTATELEFT
  myCat.turn("L",5);  
  }
  else if(key == 'w' ) { //UPWARD
  myCat.move("U",5); 
  }
  else if(key == 'a' ) { //BACKWARD
  myCat.move("L",5);  
  }
  else if(key == 's' ) { //DOWNWARD
  myCat.move("D",5);   
  }
  else if(key == 'd' ) { //FORWARD
  myCat.move("R",5);  
  }
}

class Cat {
  PImage picturecat;
  float posx, posy, picWidth, picHeight, radians = 0;

  Cat() { 
    picturecat = loadImage("cat.png");
    picWidth = 200;
    picHeight = 150;
    posx = 400;
    posy = 400;
  }
  
  Cat(int size) { 
    picturecat = loadImage("cat.png");
    picWidth = 2*size;
    picHeight = 1.5*size;
    posx = 400;
    posy = 400;
  }
  
  Cat(int size,int posx,int posy) {
    picturecat = loadImage("cat.png");
    picWidth = 2*size;
    picHeight = 1.5*size;
    this.posx = posx;
    this.posy = posy;
  }  
  
  void draw() {
    background(255);
    pushMatrix();
    translate(posx,posy);
    rotate(radians);
    translate(-picWidth/2,-picHeight/2);
    image(picturecat,0,0,picWidth,picHeight);
    popMatrix();
  }
  
  void move(String direction,float amount) { 
    switch(direction) {
      case "U" :
        posx += amount*sin(radians);
        posy -= amount*cos(radians);
        break;
      case "D" :
        posx -= amount*sin(radians);
        posy += amount*cos(radians);
        break;
      case "L" :
        posx -= amount*cos(radians);
        posy -= amount*sin(radians);
        break;
      case "R" :
        posx += amount*cos(radians);
        posy += amount*sin(radians); 
        break;
    }
  }
  
  void turn(String direction,float degrees) {
    switch(direction) {
      case "R" :
      radians = radians + degrees/180*PI;
      break;
      case "L" :
      radians = radians - degrees/180*PI;
      break;
    }
    radians = radians%TWO_PI;
  }
  
}
