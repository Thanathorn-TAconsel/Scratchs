class CatX extends command {
  CatX() {
    this.text = "Position X";
    this.sx = 95;
  }
  public String action() {
    return cat.getX() + "";
  }
}
