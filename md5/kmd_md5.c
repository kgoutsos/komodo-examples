#include "kmd_md5.h"
#include "md5.h"
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#define DATA_BASE_P (char*)0x0000F000
#define INPUT_DATA "message digest" //f96b697d7cb7938d525a2f31aaf161d0
#define INPUT_LENGTH 14 //bytes

void sleep();
void md5(char* digest, char* input, char input_length);

main ()
{
	memcpy(DATA_BASE_P, INPUT_DATA, INPUT_LENGTH);
	md5(DATA_BASE_P + INPUT_LENGTH, DATA_BASE_P, INPUT_LENGTH);

	sleep();
}

void md5(char* digest, char* input, char input_length)
{
	md5_state_t state;

	md5_init(&state);
	md5_append(&state, (const md5_byte_t *)input, input_length);
	md5_finish(&state, (md5_byte_t*)digest);
}

void __attribute__ ((naked)) irq(){}
void __attribute__ ((naked)) swi(){}

void __attribute__ ((naked)) sleep()
{
	asm ("sleep_forever: b sleep_forever");	// using asm to prevent loop elimination
}
