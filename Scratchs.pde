PImage bin16;
HashMap<String, String> globalvar = new HashMap<String, String>();
StringList oldtext = new StringList();
int N = 18;

Cat cat;
void setup() {
  size(1500, 1000);
  frameRate(60);
  bin16 = loadImage("bin16.png");
  background(0);
  textSize(15);
  cat = new Cat(80,1200,200);
  addText("Scratchs Version 3.1b");
  redraw();
}
boolean selectedcat = false;
ArrayList<command> cmd = new ArrayList<command>();
command selectedcmd, nextcmd, subcmd, selmenu, delaycommand;
int ox, oy, mx, my, tc = 1, ocx, ocy, mcx, mcy;
long nexttime;
void draw() {
  if (delaycommand != null) {
    if (millis() >= nexttime) {
      background(0);
      delaycommand.action(); 
      redraw();
      delaycommand = null;
    }
  }
  if (mousePressed) {
    if (selectedcmd != null) {
      background(0);
      selectedcmd.lx = ox + (mouseX-mx);
      selectedcmd.ly = oy + (mouseY-my);
      selectedcmd.isselected = true;
      pairfinder();
      redraw();

      if (mouseY > height - 40) {
        fill(255, 0, 0, 255);
        selectedcmd.ly = height;
      } else {
        fill(128, 0, 0, 200);
      } 
      rect(0, height - 40, width, height);
      image(bin16, width/2, height - 32);
    } else {
      if (mouseButton == LEFT) {
        cat.posx = ocx + (mouseX-mcx);
        cat.posy = ocy + (mouseY-mcy);
        println(cat.posx + "," + cat.posy);
        background(0);
        redraw();
      }
    }
  }
}
void pairfinder() {
  for (int i = 0; i < cmd.size(); i++) {
    command sel = cmd.get(i);
    sel = sel.isTouch(selectedcmd);
    if (sel != null) {
      if (nextcmd != null) {
        nextcmd.isinput = false;
      }
      nextcmd = sel;
      nextcmd.isinput = true;
      return;
    }
  }
  if (nextcmd != null) {
    nextcmd.isinput = false;
    nextcmd = null;
  }
}
void redraw() {
  
  cat.draws();
  stroke(0);
  fill(0,0,0,180);
  rect(0,0,900,1000);
  
  fill(60);
  for (int i = 0; i < 9; i++) {
    rect(i*100, 0, 100, 50);
    rect(i*100, 50, 100, 50);
  }
  fill(255);
  textSize(15);
  text("Variable", 10, 30);
  text("IF ... THEN", 110, 30);
  text("WHILE ...", 210, 30);
  text("... = ...", 310, 30);
  text("... + ... ", 410, 30);
  text("... > ... ", 510, 30);
  text("Print ... ", 610, 30);
  text("RUN ", 710, 30);
  text("VAL ", 810, 30);
  text("MOVE ... ", 10, 80);
  text("ROTATE ... ", 110, 80);
  text("DELAY ... ", 210, 80);
  text("Position X", 310, 80);
  text("Position Y", 410, 80);
  text("... ++", 510, 80);
  for (int i = 0; i < cmd.size(); i++) {
    command sel = cmd.get(i);
    sel.draw();
  }
  
  if (selectedcmd != null)selectedcmd.draw();
  if (selmenu != null) {
    fill(0, 0, 0, 127);
    rect(0, 0, width, height);
    println("OKAY");
    selmenu.drawMenu();
  }
  stroke(100);
  line(900,0,900,1000);
  fill(0,0,0,200);
  rect(900,520,600,480);
  line(900,520,1500,520);
  drawtext();
  stroke(0);
}
void keyPressed() {
  if (selmenu != null) {
    println(key + 0);
    selmenu.keyBroad(key);
  }
}
void mousePressed() {
  ocx = (int)cat.posx;
  ocy = (int)cat.posy;
  mcx = mouseX;
  mcy = mouseY;
  if (selmenu != null) {
    if (selmenu.mouseDown(mouseX, mouseY)) {
      selmenu = null;
      background(0);
    }
    redraw();
  } else {
    if (mouseButton == LEFT) {
      for (int i = 0; i < cmd.size(); i++) {
        command sel = cmd.get(i);
        println("Pressed");
        sel = sel.getClass(mouseX, mouseY, true);
        if (sel != null) {
          //println(mouseX + "," + mouseY + " : \n");
          selectedcmd = sel;
          println("Selectedsel: " + sel.text);
          if (sel.head != null) {
            println("Head: " + sel.head.text); 
            sel.head.removeChild();
            sel.child = null;
          }
          if (cmd.indexOf(sel) == -1) {
            cmd.add(sel);
          }
          ox = sel.lx;
          oy = sel.ly;
          mx = mouseX;
          my = mouseY;
          return;
        } else {
          selectedcat = true;
        }
      }
      if (mouseY < 50) {
        if (mouseX < 100) {
          var ncmd = new var(); 
          cmd.add(ncmd);
          ncmd.setName("V" + tc);
          ncmd.setValue("0");
          tc++;
          selectedcmd = ncmd;
        } else if (mouseX < 200) {
          command ncmd = new IFELSE(); 
          cmd.add(ncmd);
          selectedcmd = ncmd;
        } else if (mouseX < 300) {
          command ncmd = new WHILE(); 
          cmd.add(ncmd);
          selectedcmd = ncmd;
        } else if (mouseX < 400) {
          command ncmd = new VARSET(); 
          cmd.add(ncmd);
          selectedcmd = ncmd;
        } else if (mouseX < 500) {
          command ncmd = new operation(); 
          cmd.add(ncmd);
          selectedcmd = ncmd;
        } else if (mouseX < 600) {
          command ncmd = new comparator(); 
          cmd.add(ncmd);
          selectedcmd = ncmd;
        } else if (mouseX < 700) {
          command ncmd = new PrintVar(); 
          cmd.add(ncmd);
          selectedcmd = ncmd;
        } else if (mouseX < 800) {
          command ncmd = new runs(); 
          cmd.add(ncmd);
          selectedcmd = ncmd;
        } else if (mouseX < 900) {
          command ncmd = new consts(); 
          cmd.add(ncmd);
          selectedcmd = ncmd;
        }
      } else if (mouseY < 100) {
        if (mouseX < 100) {
          command ncmd = new Walk(); 
          cmd.add(ncmd);
          tc++;
          selectedcmd = ncmd;
        } else if (mouseX < 200) {
          command ncmd = new Rotate(); 
          cmd.add(ncmd);
          tc++;
          selectedcmd = ncmd;
        } else if (mouseX < 300) {
          command ncmd = new delays(); 
          cmd.add(ncmd);
          selectedcmd = ncmd;
        } else if (mouseX < 400) {
          command ncmd = new CatX(); 
          cmd.add(ncmd);
          selectedcmd = ncmd;
        } else if (mouseX < 500) {
          command ncmd = new CatY(); 
          cmd.add(ncmd);
          selectedcmd = ncmd;
        } else if (mouseX < 600) {
          command ncmd = new Operand(); 
          cmd.add(ncmd);
          selectedcmd = ncmd;
        } else {
          mx = mouseX;
          my = mouseY;
        }
      }
      redraw();
    } else if (mouseButton == RIGHT) {
      if (selmenu == null) {
        for (int i = 0; i < cmd.size(); i++) {
          command sel = cmd.get(i);

          sel = sel.getClass(mouseX, mouseY, false);
          if (sel != null) {

            if (sel.menu()) {
              println("Menu");
              selmenu = sel;
              //println(mouseX + "," + mouseY + " : \n");
              println("Selectedsel: " + sel.text);
            }            


            redraw();
            return;
          }
        }
      }
    }
  }
}
void mouseReleased() {

  if (selectedcmd != null) {
    background(0);  
    if (selectedcmd.ly >= height) {
      cmd.remove(selectedcmd);
    }
    selectedcmd.isselected = false;
    if (nextcmd != null) {
      nextcmd.inputs(selectedcmd);
      nextcmd.isinput = false;
      cmd.remove(selectedcmd);
      nextcmd = null;
    }
    selectedcat = false;
    selectedcmd = null;  
    subcmd = null;
    ox = 0;
    oy = 0;
    mx = 0;
    my = 0;
    redraw();
    background(0);  
    redraw();
  }
}
