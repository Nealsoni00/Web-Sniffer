import java.util.Iterator;
import org.rsg.carnivore.*;
import org.rsg.carnivore.net.*;
import org.rsg.lib.Log;

//Globals
ArrayList<Node>nodes = new ArrayList<Node>(); 

void setup() {
  
  
}
void draw() {
  
  
}

// Called each time a new packet arrives
synchronized void packetEvent(CarnivorePacket packet){
  println("[PDE] packetEvent: " + packet);
  Node newNode = new Node(packet);
  nodes.add(newNode);
}