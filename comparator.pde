class comparator extends command {
  command vts, stv;
  int conheight = 25;
  int mode = 4;
  comparator() {
    this.colors = color(255, 191, 128); 
    this.sy = 25;
    this.text = ".... = ....";
  }
  public String action() {
    if (vts != null && stv != null){
      float a = parseInt(vts.action());
      float b = parseInt(stv.action());
      boolean result = false;
      switch(mode) {
         case 0:result = a < b;break;
         case 1:result = a <= b;break;
         case 2:result = a > b;break;
         case 3:result = a >= b;;break;
         case 4:result = a == b;break;
         case 5:result = a != b;break;
      }
      if (child != null)
      child.action();
      if (result)
      return "1";
      else
      return "0";
    }
    if (child != null)
      return child.action();
    return "0";
  }
  void inputs(command child) {
    if (isinput)
      if (acceptstate == 1) {
        addChild(child);
      } else if (acceptstate == 2) {
        vts = child;
      } else if (acceptstate == 3) {
        stv = child;
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
    if (stv !=null) {
      lstv = stv.getLastChild();      
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
        rect(lx+9, ly, 20, sy);
      } else if (acceptstate == 3) {
        if (vts == null) {
          fill(255, 128, 128);
          rect(lx, ly, sx, sy);
          fill(255, 0, 0);
          rect(lx+49, ly, 20, sy);
        } else {
          fill(255, 128, 128);
          rect(lx, ly, sx, sy);
          fill(255, 0, 0);
          rect( (lvts.lx + lvts.sx) + 22, ly, 20, sy);
        }
      }
    } else {
      rect(lx, ly, sx, sy);
    }
    fill(0);
    text(text, lx+10, ly+17);
    sx = 200;
    if (vts != null) {
      vts.lx = lx + 9;
      vts.ly = ly;
      vts.draw();
      sx = ((lvts.lx +lvts.sx) - vts.lx) + 105;
      switch(mode) {
         case 0:text("< ....", (lx + sx) - 90, ly+17);break;
         case 1:text("≤ ....", (lx + sx) - 90, ly+17);break;
         case 2:text("> ....", (lx + sx) - 90, ly+17);break;
         case 3:text("≥ ....", (lx + sx) - 90, ly+17);break;
         case 4:text("= ....", (lx + sx) - 90, ly+17);break;
         case 5:text("≠ ....", (lx + sx) - 90, ly+17);break;
      }
      
      sy = lvts.ly+lvts.sy - ly;
    }
    if (stv != null) {
      if (vts == null)
      stv.lx = lx+49;
      else
      stv.lx = (lvts.lx + lvts.sx) + 22;
      stv.ly = ly;
      stv.draw();
      sx = (lstv.sx + lstv.lx) - lx;
      if (lstv.ly+lstv.sy - ly > sy) {
        sy = lstv.ly+lstv.sy - ly;  
      }
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
  boolean menu() {
    mode ++;
    if (mode > 5)mode = 0;
     switch(mode) {
         case 0:this.text = ".... < ....";break;
         case 1:this.text = ".... ≤ ....";break;
         case 2:this.text = ".... > ....";break;
         case 3:this.text = ".... ≥ ....";break;
         case 4:this.text = ".... = ....";break;
         case 5:this.text = ".... ≠ ....";break;
      }
    return false;
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
    if (stv != null) {
      output = stv.getClass(x, y,getout);
      if (output != null) {
        if (output == stv && getout) {
          stv = null;
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
    if (stv != null) {
      output = stv.isTouch(othercmd);
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
      if (othercmd.lx > lx+49 && othercmd.lx < lx+69) {
        if (stv == null) {
          acceptstate = 3;
        }
      }
    } else {
      if (othercmd.lx > (lvts.lx + lvts.sx) + 22 && othercmd.lx < (lvts.lx + lvts.sx) + 45) {
        if (stv == null) {
          acceptstate = 3;
        }
      }
    }

    if (othercmd.lx > lx+9 && othercmd.lx < lx+27) {
      if (vts == null) {
        acceptstate = 2;
      }
    }
    return this;
  }
}
