class Node {
  PVector pos;
  int radius;
  Boolean alive;
  int t1 = millis();
  int time;
  CarnivorePacket packet;
  
  Node(CarnivorePacket packet) {
    this.packet = packet;
    this.alive = true;
    calculatePos();
    
  }
  void calculatePos(){
    pos = new PVector(random(0,width),random(0,height));
  }
  void draw(){
    
  }
  void updateTime(){
   time = t1 - millis(); 
  }
}