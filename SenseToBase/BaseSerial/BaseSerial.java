import java.io.IOException;

import net.tinyos.message.*;
import net.tinyos.packet.*;
import net.tinyos.util.*;

public class BaseSerial implements MessageListener {

  private MoteIF moteIF;
  
  public BaseSerial(MoteIF moteIF) {
    this.moteIF = moteIF;
    this.moteIF.registerListener(new BaseSerialMsg(), this);
  }

  public void messageReceived(int to, Message message) {
    BaseSerialMsg msg = (BaseSerialMsg)message;
    System.out.println("Received packet: "+ msg.get_data() + " sequence number: " + msg.get_counter());
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
    BaseSerial serial = new BaseSerial(mif);
  }


}
