#include "BaseSerial.h"

configuration BaseSerialAppC {}
implementation {
  components BaseSerialC as App, LedsC, MainC;
  components SerialActiveMessageC as AMSerial;
  components new TimerMilliC();

  //
  components ActiveMessageC;
  components new AMReceiverC(AM_BASE_SERIAL_MSG);
  
  App.Boot -> MainC.Boot;
  App.Control -> AMSerial;
  App.AMSendSerial -> AMSerial.AMSend[AM_BASE_SERIAL_MSG];
  App.Leds -> LedsC;
  App.Packet -> AMSerial;

  //
  App.ControlPacket -> ActiveMessageC;
  App.ReceivePacket -> AMReceiverC;
  }


