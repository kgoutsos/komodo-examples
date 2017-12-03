#include "serial.h"

int serial_write(char* buffer, int buffer_length){
    int i, flag = 0;
    for(i=0; i<buffer_length; i++){
        if ((*SERIAL_STATUS_P) == 0x0002){
            *SERIAL_P = buffer[i];
            flag = 1;
        }
    }
    return flag;
}

char serial_read_char(){
	unsigned int status = (*SERIAL_STATUS_P) && 0x01;
	if(status==1){
		return (unsigned char)*SERIAL_P;
	}
	return 0;
}
