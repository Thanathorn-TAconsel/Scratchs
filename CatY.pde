class CatY extends command {
  CatY() {
    this.text = "Position Y";
  }
  public String action() {
    return cat.getY() + "";
  }
}
