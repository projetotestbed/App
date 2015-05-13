
#ifndef SENSE_SERIAL_H
#define SENSE_SERIAL_H

typedef nx_struct sense_serial_msg {
  nx_uint16_t error;
  nx_uint16_t data;
  nx_uint16_t counter;
  nx_uint16_t OriId;
} sense_serial_msg_t;

enum {
  AM_SENSE_SERIAL_MSG = 0x89,
  TIMER_PERIOD_MILLI = 250,
  PACKET_TO_ID = 1,
};

#endif
