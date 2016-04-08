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
  size(1000, 600);
  //fullScreen();
  c = new CarnivoreP5(this);
  c.setVolumeLimit(19);
}
void draw() {
  background(255);
  for (int i = 0; i < nodes.size(); i++) {
    Node node = nodes.get(i);
    node.draw();
    if (!node.alive) {
      nodes.remove(i);
      nodeHM.put(node.ip, null);
    }
  }
  for (int i = 0; i < connections.size(); i++) {
    Connection connect = connections.get(i);
    if (connect != null) {
      connect.draw();
      if (!connect.alive) {
        connections.remove(i);
      }
    }
  }
}

String myIP() {
  try {
    inet = InetAddress.getLocalHost();
    println("my ip: " + inet.getHostAddress());
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
  //String port = packet.substring(packet.indexOf(" ")+1);
  Node r = nodeHM.get(receiver); //check to see if it is alreay in hashmap
  Node s = nodeHM.get(sender); //

  if (r != null) {
    if (r.radius < 100) {
      r.radius += 1;
    } else {
      r.radius = 100;
    }    
    r.t1 = millis();
  } else {
    nodes.add(new Node(receiver));
    nodeHM.put(receiver, nodes.get(nodes.size()-1));
    r = nodes.get(nodes.size()-1);
  }
  if (s != null) {
    if (s.radius < 100) {
      s.radius += 1;
    } else {
      s.radius = 100;
    }
    s.t1 = millis();
  } else {
    nodes.add(new Node(sender)); 
    nodeHM.put(sender.toString(), nodes.get(nodes.size()-1));
    s = nodes.get(nodes.size()-1);
  }
  connections.add(new Connection(r, s, rPort));
  //println("[PDE] packetEvent: " + packet);
}