class Connection {
  Node fromNode;
  Node toNode;
  boolean alive;
  int t1 = millis();
  float easing = 0.1;
  PVector pos;
  int port;
  Connection(Node from, Node to, int port) {
    fromNode = from;
    toNode = to;
    alive = true;
    pos = new PVector(fromNode.pos.x, fromNode.pos.y);
    this.port = port;
  }
  void draw() {
    switch (port) {
      case: 80
    }
    fill(0, 120, 255);

    //line(fromNode.pos.x, fromNode.pos.y, toNode.pos.x, toNode.pos.y);
    float targetX = toNode.pos.x;
    float dx = targetX - pos.x;
    pos.x += dx * easing;

    float targetY = toNode.pos.y;
    float dy = targetY - pos.y;
    pos.y += dy * easing;
    ellipse(pos.x, pos.y, 10, 10);
    if (abs(dist(pos.x, pos.y, toNode.pos.x, toNode.pos.y)) < 5) {
      alive = false;
    }else{
      alive = true; 
    }
  }
}