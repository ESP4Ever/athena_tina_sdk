CC=`pwd`/../../../prebuilt/gcc/linux-x86/aarch64/toolchain-sunxi-glibc/toolchain/bin/aarch64-openwrt-linux-gnu-gcc

TARGET=rtc_time_set

all:$(TARGET)
	
rtc_time_set:rtc_demo.c
	$(CC) -o $@ $^
				
clean:
	rm -rf  $(TARGET)  *.o

.PHONY : all rtc_time_set

