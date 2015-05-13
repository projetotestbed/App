#include "SenseSerial.h"

configuration SenseSerialAppC {}
implementation {
  components SenseSerialC as App, LedsC, MainC;
  components SerialActiveMessageC as AMSerial;
  components new TimerMilliC();

  //
  components new AMSenderC(AM_SENSE_SERIAL_MSG);
  components ActiveMessageC;
  components new AMReceiverC(AM_SENSE_SERIAL_MSG);
  components new DemoSensorC();

  App.Boot -> MainC.Boot;
  App.Control -> AMSerial;
  App.AMSendSerial -> AMSerial.AMSend[AM_SENSE_SERIAL_MSG];
  App.Leds -> LedsC;
  App.MilliTimer -> TimerMilliC;
  App.Packet -> AMSerial;

  //
  App.AMSendPacket -> AMSenderC;
  App.ControlPacket -> ActiveMessageC;
  App.ReceivePacket -> AMReceiverC;
  App.Read -> DemoSensorC;
}


