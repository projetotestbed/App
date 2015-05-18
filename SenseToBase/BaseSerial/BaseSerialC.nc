#include "Timer.h"
#include "BaseSerial.h"

module BaseSerialC {
  uses {
    interface SplitControl as Control;
    interface Leds;
    interface Boot;
    interface AMSend as AMSendSerial;
    interface Packet;
    interface SplitControl as ControlPacket;
    interface Receive as ReceivePacket;
  }
}

implementation {
  message_t packet;
  base_serial_msg_t* BufferData[LENGTH_BUFFER];
  int contMsg = 0;
  int counter=0;
  nx_uint16_t media;  
  int i;
  
  event void Boot.booted() {
    call Control.start();
  }

  event void Control.startDone(error_t err) {
      call ControlPacket.start();
  }  

  event void ControlPacket.startDone(error_t err) {}
  
  event message_t* ReceivePacket.receive(message_t* bufPtr, 
				   void* payload, uint8_t len) {
    //call Leds.led1Toggle();
    if (len != sizeof(base_serial_msg_t)) {return bufPtr;}
    else {
		
	if(contMsg < LENGTH_BUFFER){
	      base_serial_msg_t* rsm = (base_serial_msg_t*)payload;
	      BufferData[contMsg]->error = rsm->error;
	      BufferData[contMsg]->data = rsm->data;
	      BufferData[contMsg]->counter = rsm->counter;
	      contMsg++;		
	      //call Leds.led0Toggle();
	      	
	}
	else{
             base_serial_msg_t* rcm = (base_serial_msg_t*)call Packet.getPayload(&packet, sizeof(base_serial_msg_t));
 	     
	     media = 0;
	     counter++;
	     for(i=0;i < contMsg;i++){
		media += BufferData[i]->data/contMsg;
	     }
	     rcm->error = BufferData[LENGTH_BUFFER-1]->error;
	     rcm->data = media;
             rcm->counter = counter;
 	     call AMSendSerial.send(AM_BROADCAST_ADDR, &packet, sizeof(base_serial_msg_t));    	
	     contMsg = 0;	
	     //call Leds.led2Off();
	}
     }
      return bufPtr;

  }


  event void AMSendSerial.sendDone(message_t* bufPtr, error_t error) {}
  event void Control.stopDone(error_t err) {}
  event void ControlPacket.stopDone(error_t err) {}

}




