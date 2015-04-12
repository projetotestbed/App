#include "Timer.h"
#include "SenseSerial.h"

module SenseSerialC {
  uses {
    interface SplitControl as Control;
    interface Leds;
    interface Boot;
    interface AMSend as AMSendSerial;
    interface Timer<TMilli> as MilliTimer;
    interface Packet;
    interface AMSend as AMSendPacket;
    interface SplitControl as ControlPacket;
    interface Receive as ReceivePacket;
    interface Read<uint16_t>;
  }
}

implementation {
  message_t packet;
  message_t packet1;
  bool locked = FALSE;
  uint16_t counter = 0;

  event void Boot.booted() {
    call Control.start();
  }

  event void ControlPacket.startDone(error_t err) {
    if (err == SUCCESS) {
      call MilliTimer.startPeriodic(TIMER_PERIOD_MILLI);
    }
  }
  
  event void Control.startDone(error_t err) {
      call ControlPacket.start();
  }  

  event void MilliTimer.fired() {
    call Read.read();
  }

  event void Read.readDone(error_t result, uint16_t data) {
    counter++;
    if (locked) {
      return;
    }
    else {
      sense_serial_msg_t* rcm = (sense_serial_msg_t*)call Packet.getPayload(&packet, sizeof(sense_serial_msg_t));
      if (rcm == NULL) {return;}
      if (call Packet.maxPayloadLength() < sizeof(sense_serial_msg_t)) {
	return;
      }
      rcm->error = result;
      rcm->data = data;
      rcm->counter = counter;
      rcm->OriId = TOS_NODE_ID;
      
      if (call AMSendPacket.send(PACKET_TO_ID, &packet, sizeof(sense_serial_msg_t)) == SUCCESS) {
        call Leds.led0Toggle();
	locked = TRUE;
      }
    }
  }

  event message_t* ReceivePacket.receive(message_t* bufPtr, 
				   void* payload, uint8_t len) {
    call Leds.led1Toggle();
    if (len != sizeof(sense_serial_msg_t)) {return bufPtr;}
    else {
      sense_serial_msg_t* rsm = (sense_serial_msg_t*)payload;
      sense_serial_msg_t* rcm = (sense_serial_msg_t*)call Packet.getPayload(&packet1, sizeof(sense_serial_msg_t));
      rcm->error = rsm->error;
      rcm->data = rsm->data;
      rcm->counter = rsm->counter;
      rcm->OriId = rsm->OriId;
      	
      call AMSendSerial.send(AM_BROADCAST_ADDR, &packet1, sizeof(sense_serial_msg_t));
    }
      return bufPtr;
  }

  event void AMSendPacket.sendDone(message_t* bufPtr, error_t error) {
    if (&packet == bufPtr) {
      locked = FALSE;
    }
  }

  event void AMSendSerial.sendDone(message_t* bufPtr, error_t error) {}
  event void Control.stopDone(error_t err) {}
  event void ControlPacket.stopDone(error_t err) {}
}




