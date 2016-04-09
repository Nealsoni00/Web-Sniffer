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