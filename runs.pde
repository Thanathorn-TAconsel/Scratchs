class runs extends command {
  runs() {
     this.text = "► RUN"; 
  }
  boolean menu() {
    background(0);
    if (child != null)
      child.action();
    return false;
  }
}
