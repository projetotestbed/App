
#ifndef BASE_SERIAL_H
#define BASE_SERIAL_H

typedef nx_struct base_serial_msg {
  nx_uint16_t error;
  nx_uint16_t data;
  nx_uint16_t counter;
  nx_uint16_t OriId;
} base_serial_msg_t;

enum {
  AM_BASE_SERIAL_MSG = 0x89,
  LENGTH_BUFFER = 10,
};

#endif
