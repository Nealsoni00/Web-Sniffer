import java.util.Iterator;
import org.rsg.carnivore.*;
import org.rsg.carnivore.net.*;
import org.rsg.lib.Log;

//Globals
ArrayList<Node>nodes = new ArrayList<Node>(); 
HashMap<String, Node> nodeHM = new HashMap<String, Node>();
ArrayList<Connection> connections = new ArrayList<Connection>();
CarnivoreP5 c;

void setup() {
  size(1000,600);
  //fullScreen();
  c = new CarnivoreP5(this);
}
void draw() {
  background(255);


  for (int i = 0; i < nodes.size(); i++) {
    Node node = nodes.get(i);
    node.draw();
    if (!nodes.get(i).alive) {
      nodes.remove(i);
    }
  }
  for (int i = 0; i < connections.size(); i++) {
    Connection connect = connections.get(i);
    if (connect != null) {
      connect.draw();
    }
    if (!connect.alive) {
      connections.remove(i);
      println("removed");
    }
  }
}


// Called each time a new packet arrives
synchronized void packetEvent(CarnivorePacket packet) {
  String reciver = packet.receiverAddress.ip.toString();
  String sender = packet.senderAddress.ip.toString();

  Node r = nodeHM.get(reciver); //check to see if it is alreay in hashmap
  Node s = nodeHM.get(sender);

  if (r != null && r.radius < 100) {
    r.radius += 1;
  } else {
    nodes.add(new Node(reciver));
    nodeHM.put(reciver, nodes.get(nodes.size()-1));
    r = nodes.get(nodes.size()-1);
  }
  if (s != null && s.radius < 100) {
    s.radius += 1;
  } else {
    nodes.add(new Node(sender)); 
    nodeHM.put(sender.toString(), nodes.get(nodes.size()-1));
    s = nodes.get(nodes.size()-1);
  }
  connections.add(new Connection(r, s));
  //println("[PDE] packetEvent: " + packet);
}