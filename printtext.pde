void addText(String Text){
  int count=1;
  textSize(20);
  oldtext.append(Text);
  println(Text);
  /*
  if (oldtext.size()<N){
    for(int n=0;n<oldtext.size();n++){
      String data = oldtext.get(n);
      fill(0, 408, 612);
      text(data, 40, 50+(40*count)); 
      
      count++;
    }
  }
  else{
    for (int i = oldtext.size(); i >= (oldtext.size() - (N-1));i-- ){
      fill(0, 408, 612);
      String data = oldtext.get((oldtext.size()-(N+1))+count);
      text(data, 40, 50+(40*count)); 
      
      count++;
    }
  }
  */
}
void drawtext() {
  int count=1;
  textSize(20);
  if (oldtext.size()<N){
    for(int n=0;n<oldtext.size();n++){
      String data = oldtext.get(n);
      fill(0, 408, 612);
      text(data, 40, 100+(40*count)); 
      
      count++;
    }
  }
  else{
    for (int i = oldtext.size(); i >= (oldtext.size() - (N-1));i-- ){
      fill(0, 408, 612);
      String data = oldtext.get((oldtext.size()-(N+1))+count);
      text(data, 40, 100+(40*count)); 
      
      count++;
    }
  }
}
