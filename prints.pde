class prints extends command{
  String varname = "";
  String value = "";
  int sel = 1;
  prints() {  
    this.text = ">>";
  }
  public String action() {
    println("OUT: " + varname);
    if (child != null)
      return child.action();
    return "0";
  }
  void keyBroad(char k) {
    if (k == 8) {
      if (sel == 1) {
         varname = backspace(varname);
         setName(varname);
      } else if (sel == 2) {
        value = backspace(value);
      }
    } else if ((k >= 'A' && k <= 'Z') || (k >= 'a' && k <= 'z') || (k >= '0' && k <= '9')){
      if (sel == 1) {
         varname += k; 
         setName(varname);
      } else if (sel == 2) {
        value += k;
      } 
    }
    drawMenu();
  }
  boolean mouseDown(int x,int y){
    if (x < mlx || x > mlx+msx || y < mly || y > mly+msy) {
      return true;
    } else {
      if (x > mlx + 20 && x < (mlx + 20) + msx && y > mly + 90 && y < (mly+90) + 20){
         sel = 1; 
      }else if (x > mlx + 20 && x < (mlx + 20) + msx && y > mly + 140 && y < (mly+140) + 20){
         sel = 2; 
      }
      return false; 
    }
  }
  boolean menu() {
    return true;
  }
  void setName(String name){
    this.varname = name;
    this.text = ">> " + name;
  }
  void drawMenu() {
    fill(40);
    rect(mlx, mly, msx, msy);
    fill(255);
    textSize(30);
    text(text, mlx + 20, mly + 50);
    textSize(15);

    text("Display Text  ", mlx + 20, mly + 80);
    fill(255);
    rect(mlx + 20, mly + 90, 200, 20);
    fill(0);
    if (sel == 1)
      text(varname + "|", mlx + 25, mly + 105);
    else
      text(varname, mlx + 25, mly + 105);

    fill(255);
    text("NOTE  ", mlx + 20, mly + 130);
    fill(255);
    rect(mlx + 20, mly + 140, 200, 20);
    fill(0);
    if (sel == 2)
      text(value + "|", mlx + 25, mly + 155);
    else
      text(value, mlx + 25, mly + 155);
  }
  
}
