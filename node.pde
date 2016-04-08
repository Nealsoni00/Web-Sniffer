class Node {
  PVector pos;
  Boolean alive;
  int t1 = millis();
  int time;
  String ip;
  int radius;
  color c = color(0, 0, 0);
  //CarnivorePacket packet;

  Node(String ip) {
    this.alive = true;
    this.ip = ip.split("/")[1];
    calculatePos();
    radius = 20;
    println(ip);
  }
  void calculatePos() {
    pos = new PVector(random(0, width), random(0, height));
  }
  void draw() {
    fill(255);
    stroke(0);
    if (myIP().equals(ip)) {
      fill(42, 213, 245, 100);
      pos = new PVector(width/2, height/2);
    }
    ellipse(pos.x, pos.y, radius, radius);
    textSize(10);
    fill(0);
    text(ip, pos.x, pos.y);
    if (millis()-t1 > 10000) {
      alive = false;
      
    }
  }
}