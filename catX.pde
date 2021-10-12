class CatX extends command {
  CatX() {
    this.text = "Position X";
  }
  public String action() {
    return cat.getX() + "";
  }
}
