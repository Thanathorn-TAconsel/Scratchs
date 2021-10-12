class VARSET extends command {
  command vts, stv;
  int conheight = 25;
  public String action() {
    if (vts != null && stv != null) {
      var A = (var)vts;
      A.setValue(stv.action());
    }
    if (child != null)
    return child.action();
    return "0";
  }
  VARSET() {
    this.colors = color(0, 255, 255); 
    this.sy = 25;
    this.text = "SET .... TO ....";
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
      this.text = "SET";
    } else {
      this.text = "SET .... TO ....";
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
        rect(lx+40, ly, 20, sy);
      } else if (acceptstate == 3) {
        if (vts == null) {
          fill(255, 128, 128);
          rect(lx, ly, sx, sy);
          fill(255, 0, 0);
          rect(lx+90, ly, 20, sy);
        } else {
          fill(255, 128, 128);
          rect(lx, ly, sx, sy);
          fill(255, 0, 0);
          rect( (lvts.lx + lvts.sx) + 35, ly, 20, sy);
        }
      }
    } else {
      rect(lx, ly, sx, sy);
    }
    fill(0);
    text(text, lx+10, ly+17);
    sx = 200;
    if (vts != null) {
      vts.lx = lx + 40;
      vts.ly = ly;
      vts.draw();
      sx = ((lvts.lx +lvts.sx) - vts.lx) + 105;
      text("TO ....", (lx + sx) - 55, ly+17);
      sy = lvts.ly+lvts.sy - ly;
    }
    if (stv != null) {
      if (vts == null)
      stv.lx = lx+90;
      else
      stv.lx = (lvts.lx + lvts.sx) + 35;
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
      if (othercmd.lx > lx+90 && othercmd.lx < lx+110) {
        if (stv == null) {
          acceptstate = 3;
        }
      }
    } else {
      if (othercmd.lx > (lvts.lx + lvts.sx) + 35 && othercmd.lx < (lvts.lx + lvts.sx) + 55) {
        if (stv == null) {
          acceptstate = 3;
        }
      }
    }

    if (othercmd.lx > lx+40 && othercmd.lx < lx+60) {
      if (vts == null) {
        acceptstate = 2;
      }
    }
    return this;
  }
}
