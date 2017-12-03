#ifndef SERIAL_H
#define SERIAL_H

#define SERIAL_P (int*)0x10000010
#define SERIAL_STATUS_P (int*)0x10000014

int serial_write(char* buffer, int buffer_length);
int serial_write_char(char ctr);
char serial_read_char();

#endif
