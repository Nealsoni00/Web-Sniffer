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
  color port2color(int port) {
    color color1  = color(0, 0, 0, 170);           //0x000000 black  unknown
color color2  = color(153, 0, 204, 170);   //0x9900CC purple  ftp
color color3  = color(51, 51, 204, 170);   //0x3333CC darkblue     itunes
color color4  = color(102, 102, 255, 170);   //0x6666FF blue    http
color color5  = color(51, 102, 102, 170);   //0x336666 darkgreen    email
color color6  = color(102, 153, 0, 170);   //0x669900 green  aim
color color7  = color(204, 255, 102, 170);   //0xCCFF66 lightgreen   Network Time Protocol
color color8  = color(255, 204, 0, 170);   //0xFFCC00 tan    telnet/ssh
color color9  = color(255, 153, 0, 170);   //0xFF9900 orange  BOOTP client
color color10 = color(255, 102, 102, 170);   //0xFF6666 pink    netbios
color color11 = color(204, 0, 0, 170);           //0xCC0000 red    name-domain server
    if(port == 21)   { return color2  ; }   //ftp
    if(port == 22)   { return color8  ; }   //ssh
    if(port == 25)   { return color5  ; }   //smtp
    if(port == 53)   { return color11 ; }   //name-domain server
    if(port == 5353) { return color11 ; }   //name-domain server
    if(port == 68)   { return color9  ; }   //BOOTP client
    if(port == 69)   { return color9  ; }   //BOOTP client
    if(port == 80)   { return color4  ; }   //http
    if(port == 8020) { return color4  ; }   //http
    if(port == 443)  { return color4  ; }   //https
    if(port == 110)  { return color5  ; }   //pop3
    if(port == 123)  { return color7  ; }   //Network Time Protocol
    if(port == 137)  { return color10 ; }   //NETBIOS
    if(port == 138)  { return color10 ; }   //NETBIOS
    if(port == 139)  { return color10 ; }   //NETBIOS
    if(port == 427)  { return color3  ; }   //itunes?
    if(port == 5190) { return color6  ; }   //aim
    return color1;
  }
}