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

    fill(portColor(port)[0]);
    stroke(portColor(port)[1]);

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
    } else {
      alive = true;
    }
  }

  color[] portColor(int port) {
    color s = color(125);
    color c = color(125);
    switch (port) {
    case 21:
      c = color(153, 0, 204, 255); //ftp
      break;
    case 22:
      c = color(255, 204, 0, 255); //ssh
      break;
    case 25:
      c = color(51, 102, 102, 255); //smtp (email)
      break;
    case 5353:
    case 53:
      c = color(51, 102, 102, 255); //dns
      break;
    case 69:
    case 68:
      c = color(255, 153, 0, 255); //BOOTP
      break;
    case 40:
    case 80:
      c =  color(102, 102, 255, 255); //https
      break;
    case 443:
      c =  color(102, 102, 255, 255); //https
      s = color(244, 245, 42, 255); //https
      break;
    case 110:
      c = color(51, 102, 102, 255);  //pop3
      break;
    case 123:
      c = color(204, 255, 102, 255);  //network time protocol
      break;
    case 137:
    case 138:
    case 139:
      c = color(255, 102, 102, 255);  //netbios
      break;    
    case 427:
      c = color(51, 51, 204, 255);  //itunes
      break;    
    default:
      s = color(125);
      c = color(125);
      break;
    } 
    color[] colorArray = {c, s};
    return colorArray;
  }
}