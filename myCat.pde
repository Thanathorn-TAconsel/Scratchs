class Cat {
  PImage picturecat;
  float posx, posy, picWidth, picHeight, radians = 0;
  float defX ,defY;
  Cat() { 
    picturecat = loadImage("cat.png");
    picWidth = 200;
    picHeight = 150;
    posx = 400;
    posy = 400;
    defX = posx;
    defY = posy;
  }
  
  Cat(int size) { 
    picturecat = loadImage("cat.png");
    picWidth = 2*size;
    picHeight = 1.5*size;
    posx = 400;
    posy = 400;
    defX = posx;
    defY = posy;
  }
  
  Cat(int size,int posx,int posy) {
    picturecat = loadImage("cat.png");
    picWidth = 2*size;
    picHeight = 1.5*size;
    this.posx = posx;
    this.posy = posy;
    defX = posx;
    defY = posy;
  }  
  
  void draws() {
    pushMatrix();
    translate(posx,posy);
    rotate(radians);
    translate(-picWidth/2,-picHeight/2);
    image(picturecat,0,0,picWidth,picHeight);
    popMatrix();
  }
  float getX() {
     return posx - defX; 
  }
  float getY() {
     return posy - defY; 
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
