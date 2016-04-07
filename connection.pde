class Connection {
  Node fromNode;
  Node toNode;
  boolean alive;
  int t1 = millis();
  Connection(Node from, Node to) {
    fromNode = from;
    toNode = to;
    alive = true;
    
  }
  void draw() {
    line(fromNode.pos.x, fromNode.pos.y, toNode.pos.x, toNode.pos.y);
    if (millis()-t1 > 1000){
       alive = false; 
    }
}
  
}