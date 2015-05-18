import java.io.IOException;

import net.tinyos.message.*;
import net.tinyos.packet.*;
import net.tinyos.util.*;

public class SenseSerial implements MessageListener {

  private MoteIF moteIF;
  
  public SenseSerial(MoteIF moteIF) {
    this.moteIF = moteIF;
    this.moteIF.registerListener(new SenseSerialMsg(), this);
  }

  public void messageReceived(int to, Message message) {
    SenseSerialMsg msg = (SenseSerialMsg)message;
    System.out.println("Send packet: "+ msg.get_data() + " from: " + msg.get_OriId() + " sequence number: " + msg.get_counter());
  }
  
  private static void usage() {
    System.err.println("usage: SenseSerial [-comm <source>]");
  }
  
  public static void main(String[] args) throws Exception {
    String source = null;
    if (args.length == 2) {
      if (!args[0].equals("-comm")) {
	usage();
	System.exit(1);
      }
      source = args[1];
    }
    else if (args.length != 0) {
      usage();
      System.exit(1);
    }
    
    PhoenixSource phoenix;
    
    if (source == null) {
      phoenix = BuildSource.makePhoenix(PrintStreamMessenger.err);
    }
    else {
      phoenix = BuildSource.makePhoenix(source, PrintStreamMessenger.err);
    }

    MoteIF mif = new MoteIF(phoenix);
    SenseSerial serial = new SenseSerial(mif);
  }


}
