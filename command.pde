class command {
  int lx = 0, ly = 0, sx = 75, sy = 25;
  String text = "NOT SET "; 

  boolean isinput = false;
  int acceptstate = 0;
  color colors = color(255, 255, 255);
  boolean isselected = false;
  int msx = 300;
  int msy = 200;
  int mlx = width/2 - msx/2;
  int mly = height/2 - msy/2;
   boolean subtrack = false;
  int off = 10;
  command child;
  command head;
  public String action() {
    if (child != null)
      return child.action();
    return "0";
  }
  command getLastChild() {
    if (this.child != null) {
      return this.child.getLastChild();
    }
    return this;
  }
  command() {
    
  }
  /*
  void setColor(color colors) {
   this.colors = colors;
   }
   */
  void addToLast(command child) {
    if (this.child != null) {
      this.child.addToLast(child);
    } else {
      child.head = this;
      this.child = child;
    }
  }
  void inputs(command child) {
    if (isinput)
      if (acceptstate == 1)addChild(child);
    acceptstate = 0;
  }
  void addChild(command child) {
    /*
    if (this.head == null) {
     if (this.child != null)
     this.child.addChild(child);
     else {
     child.head = this;
     this.child = child;  
     }
     } else {
     child.head = this.head;
     child.addToLast(this);
     this.head.child = child;
     this.head = child;  
     }
     */

    child.head = this;

    if (this.child != null) {
      child.addToLast(this.child);
    }
    this.child = child;


    /*
    if (this.child != null) {
     
     this.child.addChild(child);
     return;
     }
     child.head = this; 
     this.child = child;
     */
  }

  void removeChild() {
    if (this.child != null) {
      this.child.head = null;
      if (this.child.child != null) {
        this.child = this.child.child; 
        this.child.head = this;
      } else {
        this.child = null;
      }
    }
  }
  void draw() {
    if (isselected)
      fill(255, 255, 0, 128);
    else
      if (acceptstate == 1 && isinput)
        fill(255, 128, 128);
      else
        fill(colors);
    rect(lx, ly, sx, sy);
    fill(0);
    textSize(15);
    text(text, lx+10, ly+17);

    if (this.child != null) {
      if (this.head == null) {
        this.child.lx = this.lx+off;
        this.child.ly = this.ly + this.sy;
      } else {
        this.child.lx = this.lx;
        this.child.ly = this.ly + this.sy;
      }
      this.child.draw();
    }
  }
  command getClass(int x, int y,boolean getout) {
    if (x > lx && x < lx + sx && y > ly && y < ly+sy) {

      return this;
    } else {
      if (this.child != null) {
        return this.child.getClass(x, y,getout);
      }
    }
    return null;
  }
  boolean menu() {
    println("Menu " + text);
    return false;
  }
  
  void drawMenu() {
      
  }
  void keyBroad(char k) {
    
  }
  String backspace(String in) {
      if (in.length() > 0)
      return in.substring(0,in.length()-1);
      return in;
  }
  
  boolean mouseDown(int x,int y){
    return true;
  }
  command Touch(command othercmd) {
    acceptstate = 1;
    return this;
  }
  command isTouch(command othercmd) {
    /*if ( (othercmd.lx < lx + sx && othercmd.lx > lx || 
     othercmd.lx + othercmd.sx < lx + sx && othercmd.lx + othercmd.sx > lx) &&
     (othercmd.ly < ly + sy && othercmd.ly > ly ||
     othercmd.ly + othercmd.sy < ly + sy && othercmd.ly + othercmd.sy > ly
     )) {
     return Touch(othercmd); 
     } */

    if ( (othercmd.lx < lx + sx && othercmd.lx > lx ) &&
         (othercmd.ly < ly + sy && othercmd.ly > ly )
       ) {
      return Touch(othercmd);
    } else {
      acceptstate = 0;
      if (this.child != null) {
        return this.child.isTouch(othercmd);
      }
    }
    return null;
  }
}
