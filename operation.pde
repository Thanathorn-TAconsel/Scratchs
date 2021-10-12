class operation extends command {
  command vts, stv;
  int conheight = 25;
  char mode = '+';
  int offL = 15;
  operation() {
    this.colors = color(255, 191, 128); 
    this.sy = 25;
    this.text = ".... + ....";
  }
  public String action() {
    if (vts != null && stv != null) {
      String result = "";
      if (isfloat(vts.action()) && isfloat(stv.action())) {
        float a = parseFloat(vts.action());
        float b = parseFloat(stv.action());
        float results = 0;
        switch(mode) {
        case '+':
          results = a + b;
          break;
        case '-':
          results = a - b;
          break;
        case '*':
          results = a * b;
          break;
        case '/':
          results = a / b;
          break;
        }
        result = results + "";
      } else {
        result = vts.action() + stv.action();
      }

      if (child != null)
        child.action();
      println("CALC: " + result);
      return result + "";
    }
    if (child != null)
      return child.action();
    return "0";
  }
  boolean isfloat(String s) {
    boolean result = false;
    try {
      Float.parseFloat(s);
      result = true;
    }
    catch(NumberFormatException e) {
    }
    return result;
  }

  void inputs(command child) {
    if (isinput)
      if (acceptstate == 1) {
        addChild(child);
      } else if (acceptstate == 2) {
        vts = child;
        vts.subtrack = true;
      } else if (acceptstate == 3) {
        stv = child;
        stv.subtrack = true;
      }
    redraw();
    acceptstate = 0;
  }
  command lvts;
  command lstv;
  boolean menu() {
    if (mode == '+')mode = '-';
    else if (mode == '-')mode = '*';
    else if (mode == '*')mode = '/';
    else mode = '+';

    return false;
  }
  void draw() {
    if (this.subtrack) {
      offL = 20;
    } else {
      offL = 0;
    }
    if (vts !=null) {
      lvts = vts.getLastChild();
      this.text = "";
    } else {
      this.text = ".... " + mode + " ....";
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
        rect(lx+9+offL, ly, 20, sy);
      } else if (acceptstate == 3) {
        if (vts == null) {
          fill(255, 128, 128);
          rect(lx, ly, sx, sy);
          fill(255, 0, 0);
          rect(lx+49+offL, ly, 20, sy);
        } else {
          fill(255, 128, 128);
          rect(lx, ly, sx, sy);
          fill(255, 0, 0);
          if (subtrack) {
              rect( (lvts.lx + lvts.sx+offL)+7, ly, 20, sy);
          } else {
            rect( (lvts.lx + lvts.sx+offL) + 24, ly, 20, sy);
          }
          
        }
      }
    } else {
      rect(lx, ly, sx, sy);
    }
    fill(0);
    text(text, lx+10+offL, ly+17);
    sx = 200;
    if (vts != null) {
      vts.lx = lx + 9+offL;
      vts.ly = ly;
      vts.draw();
      sx = ((lvts.lx +lvts.sx) - vts.lx) + 105;
      text(mode + "  ....", (lx + sx+offL) - 90, ly+17);
      sy = lvts.ly+lvts.sy - ly;
    }
    if (stv != null) {
      if (vts == null)
        stv.lx = lx+49+offL;
      else
        stv.lx = (lvts.lx + lvts.sx) + 22;
      stv.ly = ly;
      stv.draw();
      sx = (lstv.sx + lstv.lx) - lx;
      if (lstv.ly+lstv.sy - ly > sy) {
        sy = lstv.ly+lstv.sy - ly;
      }
      sx += offL*1.5;
    }
    if (this.subtrack) {
      text("(",lx+10,ly+17);
      text(")",lx+sx - 17,ly+17);
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
  command getClass(int x, int y, boolean getout) {
    command output = null;
    if (vts != null) {
      output = vts.getClass(x, y, getout);
      if (output != null) {
        if (output == vts && getout) {
          vts.subtrack = false;
          vts = null;
        }
        return output;
      }
    }
    if (stv != null) {
      output = stv.getClass(x, y, getout);
      if (output != null) {
        if (output == stv && getout) {
          stv.subtrack = false;
          stv = null;
        }
        return output;
      }
    }
    output = super.getClass(x, y, getout);
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
      if (othercmd.lx > lx+49+offL  && othercmd.lx < lx+69+offL) {
        if (stv == null) {
          acceptstate = 3;
        }
      }
    } else {
      if (subtrack) {
        if (othercmd.lx > (lvts.lx + lvts.sx + offL)+7 && othercmd.lx < (lvts.lx + lvts.sx + offL) + 45) {
          if (stv == null) {
            acceptstate = 3;
          }
        }
      } else {
        if (othercmd.lx > (lvts.lx + lvts.sx + offL) + 24 && othercmd.lx < (lvts.lx + lvts.sx + offL) + 45) {
          if (stv == null) {
            acceptstate = 3;
          }
        }
      }
    }

    if (othercmd.lx > lx+9+offL && othercmd.lx < lx+29+offL) {
      if (vts == null) {
        acceptstate = 2;
      }
    }
    return this;
  }
}
