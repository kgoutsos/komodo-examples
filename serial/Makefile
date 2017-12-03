CROSS_GCC_VER=4.6.4
TOOLCHAIN_PREFIX=/usr/local/toolchains/arm-elf-nothumb-4.6.4
TOOLCHAIN_PATH=$(TOOLCHAIN_PREFIX)/bin
CROSS_LIBGCC_PATH=$(TOOLCHAIN_PREFIX)/lib/gcc/arm-elf/$(CROSS_GCC_VER)
CROSS_LIBC_PATH=$(TOOLCHAIN_PREFIX)/arm-elf/lib

APP_NAME = kmd_serial
TOOL_PREFIX=arm-elf-
COPT= -march=armv4 -fomit-frame-pointer -ffast-math -O2 -fno-zero-initialized-in-bss

ifndef TARGET
	TARGET=all
endif

all: $(APP_NAME)_tx $(APP_NAME)_rx

$(APP_NAME)_tx: $(APP_NAME)_tx.o startup.o armfpga.ld serial.o
	$(TOOLCHAIN_PATH)/$(TOOL_PREFIX)ld -T armfpga.ld -o $(APP_NAME)_tx startup.o serial.o $(APP_NAME)_tx.o -L$(CROSS_LIBGCC_PATH) -L$(CROSS_LIBC_PATH) -lgcc -lc 
	$(TOOLCHAIN_PATH)/$(TOOL_PREFIX)objdump -d $(APP_NAME)_tx > $(APP_NAME)_tx.dmp

$(APP_NAME)_rx: $(APP_NAME)_rx.o startup.o armfpga.ld serial.o
	$(TOOLCHAIN_PATH)/$(TOOL_PREFIX)ld -T armfpga.ld -o $(APP_NAME)_rx startup.o serial.o $(APP_NAME)_rx.o -L$(CROSS_LIBGCC_PATH) -L$(CROSS_LIBC_PATH) -lgcc -lc 
	$(TOOLCHAIN_PATH)/$(TOOL_PREFIX)objdump -d $(APP_NAME)_rx > $(APP_NAME)_rx.dmp

startup.o: startup.s
	$(TOOLCHAIN_PATH)/$(TOOL_PREFIX)as -o startup.o startup.s

serial.o: serial.c serial.h
	$(TOOLCHAIN_PATH)/$(TOOL_PREFIX)gcc $(COPT) -c -o serial.o serial.c

$(APP_NAME)_tx.o: $(APP_NAME)_tx.c $(APP_NAME).h serial.h
	$(TOOLCHAIN_PATH)/$(TOOL_PREFIX)gcc $(COPT) -c -o $(APP_NAME)_tx.o $(APP_NAME)_tx.c

$(APP_NAME)_rx.o: $(APP_NAME)_rx.c $(APP_NAME).h serial.h
	$(TOOLCHAIN_PATH)/$(TOOL_PREFIX)gcc $(COPT) -c -o $(APP_NAME)_rx.o $(APP_NAME)_rx.c

clean:
	/bin/rm -f $(APP_NAME)_rx.s $(APP_NAME)_tx.s $(APP_NAME)_rx $(APP_NAME)_tx *.o *.dmp

