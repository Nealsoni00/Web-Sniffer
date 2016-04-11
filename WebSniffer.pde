import java.util.Iterator;
import org.rsg.carnivore.*;
import org.rsg.carnivore.net.*;
import org.rsg.lib.Log;
import java.net.InetAddress;

InetAddress inet;

//Globals
ArrayList<Node>nodes = new ArrayList<Node>(); 
HashMap<String, Node> nodeHM = new HashMap<String, Node>();
ArrayList<Connection> connections = new ArrayList<Connection>();
CarnivoreP5 c;

void setup() {
  size(1200, 600);
  //fullScreen();
  c = new CarnivoreP5(this);
  // c.setVolumeLimit(19);
}
void draw() {
  background(255);  
  drawKey();

  for (int i = 0; i < nodes.size(); i++) {//desplay all nodes
    Node node = nodes.get(i);
    node.draw();       //draw all of them on screen
    if (!node.alive) { //deleat nodes that are marked for deleation
      nodes.remove(i); //remove them
      nodeHM.put(node.ip, null); //remove from hashmap to be readded later
    }
  }
  for (int i = 0; i < connections.size(); i++) { //desplay all connections
    Connection connect = connections.get(i);
    if (connect != null) {  //make sure it exists
      connect.draw();       //draw all of them
      if (!connect.alive) { //deleat connections when marked for deleation
        connections.remove(i);
      }
    }
  }
}

String myIP() { //get ur computer IP address for marking later
  try {
    inet = InetAddress.getLocalHost();
    //println("my ip: " + inet.getHostAddress());
    return inet.getHostAddress();
  }
  catch (Exception e) {
    e.printStackTrace();
    return null;
  }
}


// Called each time a new packet arrives
synchronized void packetEvent(CarnivorePacket packet) {
  int rPort = packet.receiverPort;
  String receiver = packet.receiverAddress.ip.toString();
  String sender = packet.senderAddress.ip.toString();
  Node r = nodeHM.get(receiver); //check to see if it is alreay in hashmap
  Node s = nodeHM.get(sender); //and if it does we use it if it doesn't we create new node

  if (r != null && r.alive) {
    if (r.radius < 100) {   //don't want the radius to get too big
      r.radius += 1;       //increase radius for more connects to the same node
    }   
    r.t1 = millis();       //reset self destruct timer as new connection was made
  } else {
    nodes.add(new Node(receiver)); //add to arraylist to desplay
    r = nodes.get(nodes.size()-1);//the new node we just created
    nodeHM.put(receiver, r); //add to hashmap for later use
  }
  if (s != null && s.alive) {
    if (s.radius < 100) { //increase radius for more connects to the same node
      s.radius += 1;      //don't want the radius to get too big
    }
    s.t1 = millis();      //reset self destruct timer as new connection was made
  } else {
    nodes.add(new Node(sender));  //add to arraylist to desplay
    s = nodes.get(nodes.size()-1); //the new node we just created
    nodeHM.put(sender.toString(), s); //add to hashmap for later use
  }
  connections.add(new Connection(r, s, rPort)); //add to connections array to desplay on screen
  //println("[PDE] packetEvent: " + packet);
}
void drawKey() {
  textAlign(CORNER);
  int x = 10;
  int y = 20;
  int size = 12;
  textSize(12);
  fill(153, 0, 204, 255);
  text("port 20 - 21:      FTP", x, y);
  fill(255, 204, 0, 255);
  text("port 22:              SSH", x, y+size);
  fill(51, 102, 102, 255);//smtp
  text("port 25:              SMTP (Email)", x, y+size*2);
  fill(51, 102, 102, 255);
  text("port 53 & 5353:      DNS ", x, y+size*3);
  fill(255, 153, 0, 255);
  text("port 68 - 69:         BOOTP ", x, y+size*4);
  fill(102, 102, 255, 255);
  text("port 40 & 80:         HTTP", x, y+size*5);
  fill(102, 102, 255, 255);
  text("port 443:              HTTPS  ", x, y+size*6);
  fill(51, 102, 102, 255); 
  text("port 110:              POP3", x, y+size*7);
  fill(204, 255, 102, 255);  //network time protocol
  text("port 123:              NTP", x, y+size*8);
  fill(255, 102, 102, 255);  //netbios
  text("port 137-139:        NetBios", x, y+size*9);
  fill(51, 51, 204, 255);  //itunes
  text("port 427:              itunes", x, y+size*10);
  fill(205, 92, 92);
  text("port 6880-6999 or 49152-65534: BitTorrent", x, y+size*11);
  fill(125);
  text("Unknown" ,x,y+size*12);
}
