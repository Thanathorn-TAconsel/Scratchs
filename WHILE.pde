class WHILE extends command {
  command test, no, end;
  int conheight = 25;
  public String action() {
    
    while (true) {
      int result = parseInt(test.action());
      if (result > 0) {
        no.action();
      } else {
         break; 
      }
    }
    if (child != null)
      return child.action();
    return "0";
  }
  WHILE() {
    this.sx = 150;
    this.colors = color(255, 255, 0); 
    this.sy = 100;
    this.text = "WHILE .... THEN";
    this.no = new command();
    this.no.off = 0;
    this.no.text = "pass";
    no.colors = color(255, 200, 200);
    this.end = new command();
    this.end.text = "END WHILE";
    end.colors = color(255, 255, 0);
  }

  void inputs(command child) {
    if (isinput)
      if (acceptstate == 1) {
        addChild(child);
      } else if (acceptstate == 2) {
        test = child;
        //sx = test.sx+30+70;
        redraw();
      }
    acceptstate = 0;
  }
  void draw() {
    command lastChildNo = no.getLastChild();
    if (isselected) {

      fill(255, 255, 0, 128);
    } else {
      fill(colors);
    }      
    if (test != null) {
      command lastChild = test.getLastChild();

      conheight = (lastChild.ly - test.ly)+lastChild.sy;
      this.sy = conheight +25;
      this.sx = ((lastChild.lx + lastChild.sx) - test.lx)+130;
      rect(lx, ly, sx, conheight);
      fill(0);
      textSize(15);
      text("WHILE", lx+10, ly+17);  
      test.lx = this.lx + 60;
      test.ly = this.ly;
      test.draw();
      fill(255);
      //rect((lx+sx) - 70, ly, 70, conheight);
      fill(0);
      text("Then", lx + sx-50, ly+17);
    } else {
      rect(lx, ly, sx, 25);
    }
    no.lx = this.lx + 30;
    no.ly = this.ly + this.conheight;
    if (no.child == null) {
      no.sy = 25;
    } else {
      no.sy = 0;
    }
    no.draw();
    this.sy = (lastChildNo.ly - ly)+lastChildNo.sy+25;
    end.lx = this.lx;
    end.ly = this.ly + this.sy - 25;
    end.sx = sx;
    end.draw();
    if (isinput) {
      if (acceptstate == 1) {
        fill(255, 0, 0, 100);
        if (test != null) {
        }
        rect(lx, ly, sx, sy);
      }
      if (acceptstate == 2) {
        fill(255, 200, 200);
        rect(lx, ly, sx, 25);
        fill(255, 128, 128);
        rect(lx+55, ly, 25, 25);
      }
    }
    if (test == null) {
      fill(0);
      textSize(15);
      text(text, lx+10, ly+17);
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
    if (test != null) {
      output = test.getClass(x, y,getout);
      if (output != null) {
        if (output == test && getout) {
          test = null;
          conheight = 25;
        }
        return output;
      }
    }

    output = no.getClass(x, y,getout);
    if (output != null) {
      if (output == no && getout) {
        output = null;
      } else {
        return output;
      }
    }
    output = super.getClass(x, y,getout);
    return output;
  }
  command isTouch(command othercmd) {
    command output = null;
    if (test != null) {
      output = test.isTouch(othercmd);
      if (output != null) {
        return output;
      }
    }

    output = no.isTouch(othercmd);
    if (output != null) {
      return output;
    }
    output = super.isTouch(othercmd); 
    return output;
  }
  command Touch(command othercmd) {
    acceptstate = 1;
    if (othercmd.lx > lx+25 && othercmd.lx < lx+50) {
    }
    if (othercmd.lx > lx+55 && othercmd.lx < lx+80) {
      if (test == null) {
        acceptstate = 2;
      }
    }
    return this;
  }
}
