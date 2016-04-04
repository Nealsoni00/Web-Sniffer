class Node {
  PVector pos;
  int radius;
  Boolean alive;
  CarnivorePacket packet;
  
  Node(CarnivorePacket packet) {
    this.packet = packet;
    this.alive = true;
  }
}