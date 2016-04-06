import java.util.Iterator;
import org.rsg.carnivore.*;
import org.rsg.carnivore.net.*;
import org.rsg.lib.Log;

//Globals
ArrayList<Node>nodes = new ArrayList<Node>(); 

void setup() {
  fullScreen();
  
}
void draw() {
  
  
  
  for (int i = 0; i < nodes.size(); i++){
    
    if (!nodes.get(i).alive){
      nodes.remove(i);
    }
  }
}

// Called each time a new packet arrives
synchronized void packetEvent(CarnivorePacket packet){
  println("[PDE] packetEvent: " + packet);
  Node newNode = new Node(packet);
  nodes.add(newNode);
}