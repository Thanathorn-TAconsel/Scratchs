class Rotate extends command {
  command vts;
  int conheight = 25;
  public String action() {
    if (vts != null) {
      float amount = parseFloat(vts.action());
      cat.turn("R",amount);
    }
    if (child != null)
    return child.action();
    return "0";
  }
  Rotate() {
    this.colors = color(255, 255, 128); 
    this.sy = 25;
    this.text = "ROTATE ....";
  }

  void inputs(command child) {
    if (isinput)
      if (acceptstate == 1) {
        addChild(child);
      } else if (acceptstate == 2) {
        vts = child;
      }
    redraw();
    acceptstate = 0;
  }
  command lvts;
  command lstv;
  void draw() {
    if (vts !=null) {
      lvts = vts.getLastChild();      
    }

    if (isselected) {

      fill(255, 255, 0, 128);
    } else {
      fill(colors);
    }      

    if (isinput) {
      if (acceptstate == 1) {
        fill(255, 128, 128);
        rect(lx, ly, sx, sy);
      } else if (acceptstate == 2) {
        fill(255, 128, 128);
        rect(lx, ly, sx, sy);
        fill(255, 0, 0);
        rect(lx+72, ly, 20, sy);
      }
    } else {
      rect(lx, ly, sx, sy);
    }
    fill(0);
    text(text, lx+10, ly+17);
    sx = 200;
    if (vts != null) {
      vts.lx = lx + 72;
      vts.ly = ly;
      vts.draw();
      sx = ((lvts.lx +lvts.sx) - vts.lx) + 80;
      //text("TO ....", (lx + sx) - 55, ly+17);
      sy = lvts.ly+lvts.sy - ly;
    }

    if (this.child != null) {
      if (this.head == null) {
        this.child.lx = this.lx+10;
        this.child.ly = this.ly + this.sy;
      } else {
        this.child.lx = this.lx;
        this.child.ly = this.ly + this.sy;
      }
      this.child.draw();
    }
  }
  command getClass(int x, int y,boolean getout) {
    command output = null;
    if (vts != null) {
      output = vts.getClass(x, y,getout);
      if (output != null) {
        if (output == vts && getout) {
          vts = null;
        }
        return output;
      }
    }
    
    output = super.getClass(x, y,getout);
    return output;
  }

  command isTouch(command othercmd) {
    command output = null;
    if (vts != null) {
      output = vts.isTouch(othercmd);
      if (output != null) {
        return output;
      }
    }

    output = super.isTouch(othercmd); 
    return output;
  }
  command Touch(command othercmd) {
    acceptstate = 1;
    if (vts == null) {

    } else {

    }

    if (othercmd.lx > lx+72 && othercmd.lx < lx+92) {
      if (vts == null) {
        acceptstate = 2;
      }
    }
    return this;
  }
}
