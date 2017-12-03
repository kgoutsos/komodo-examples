#include <stdlib.h>
#include "kmd_serial.h"
#include "serial.h"

#define TIMER_INTERVAL_MS 500

void irq();
void sleep();
void swi();

char num_in = 'a';

main ()
{	
	/* Enabling timer interrupts */
	IRQ_ENABLE; 
	/* Unmasking the timer interrupt */
	*INT_ENABLE_P |= INT_MASK_TIMER;
	
	/* Setting the timer */
	*TIMER_COMPARE_P = *TIMER_P + TIMER_INTERVAL_MS;
	
	sleep();
}

void __attribute__ ((naked)) irq(){	
	/* Clearing interrupt flag */	
	*INT_RAW_P = 0x00;  

	num_in = serial_read_char();
	if(num_in >=0x30 && num_in<=0x38){		
		*LEDS_P = 1 << (num_in-0x30);			
		//serial_write(&("valid\n"), 6);
	}
/*	else{*/
/*		serial_write(&("invalid\n"), 8);*/
/*	}*/
	
	/* Resetting the timer */
	*TIMER_COMPARE_P = *TIMER_P + TIMER_INTERVAL_MS;
	
	/* Re-enabling timer interrupts which were disabled while switching to IRQ mode */
	IRQ_ENABLE; 

    sleep();
}

void __attribute__ ((naked)) swi(){};

void __attribute__ ((naked)) sleep()
{
	asm ("sleep_forever: b sleep_forever");	// using asm to prevent loop elimination
}
