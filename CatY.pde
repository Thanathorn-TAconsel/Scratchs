class CatY extends command {
  CatY() {
    this.text = "Position Y";
    this.sx = 95;
  }
  public String action() {
    return cat.getY() + "";
  }
}
