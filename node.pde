class Node {
  PVector pos;
  Boolean alive;
  int t1 = millis();
  int time;
  String ip;
  int radius;
  color c = color(255);
  //CarnivorePacket packet;

  int score;
  Node(String ip) {
    this.alive = true;
    this.ip = ip.split("/")[1];
    calculatePos();
    radius= 20;
    //println(ip);
  }
  void calculatePos() {//position based on IP adress
    pos = new PVector(random(0, width), random(0, height));
    if (pos.x < 150 && pos.y < 150) {
      pos.x = random(150, width);
      pos.y = random(150, height);
    }
  }
  void draw() {
    fill(c);
    stroke(0);
    if (myIP().equals(ip)) {//my ip change the color
      fill(42, 213, 245, 100);
      pos = new PVector(width/2, height/2);
    }
    ellipse(pos.x, pos.y, radius, radius);
    textSize(10);
    fill(0);
    textAlign(CENTER);//desplay IP adress
    text(ip, pos.x, pos.y);
    if (millis()-t1 > 10000) {//time out after 10 seconds of inactivity
      alive = false;
    }
  }
}
