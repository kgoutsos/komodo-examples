CROSS_GCC_VER=4.6.4
TOOLCHAIN_PREFIX=/usr/local/toolchains/arm-elf-nothumb-$(CROSS_GCC_VER)
TOOLCHAIN_PATH=$(TOOLCHAIN_PREFIX)/bin
CROSS_LIBGCC_PATH=$(TOOLCHAIN_PREFIX)/lib/gcc/arm-elf/$(CROSS_GCC_VER)
CROSS_LIBC_PATH=$(TOOLCHAIN_PREFIX)/arm-elf/lib

APP_NAME = kmd_md5
TOOL_PREFIX=arm-elf-
COPT= -march=armv4 -fomit-frame-pointer -ffast-math -O2 -fno-zero-initialized-in-bss

$(APP_NAME): $(APP_NAME).o startup.o armfpga.ld md5.o
	$(TOOLCHAIN_PATH)/$(TOOL_PREFIX)ld -T armfpga.ld -o $(APP_NAME) md5.o startup.o $(APP_NAME).o -L$(CROSS_LIBGCC_PATH) -L$(CROSS_LIBC_PATH) -lgcc -lc 
	$(TOOLCHAIN_PATH)/$(TOOL_PREFIX)objdump -d $(APP_NAME) > $(APP_NAME).dmp

md5.o: md5.c md5.h
	$(TOOLCHAIN_PATH)/$(TOOL_PREFIX)gcc $(COPT) -c -o md5.o md5.c

startup.o: startup.s
	$(TOOLCHAIN_PATH)/$(TOOL_PREFIX)as -o startup.o startup.s

$(APP_NAME).o: $(APP_NAME).c $(APP_NAME).h md5.h
	$(TOOLCHAIN_PATH)/$(TOOL_PREFIX)gcc $(COPT) -c -o $(APP_NAME).o $(APP_NAME).c

clean:
	/bin/rm -f $(APP_NAME).s $(APP_NAME) *.o *.dmp

