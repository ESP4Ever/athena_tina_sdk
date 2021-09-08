CC=`pwd`/../../../prebuilt/gcc/linux-x86/aarch64/toolchain-sunxi-glibc/toolchain/bin/aarch64-openwrt-linux-gnu-g++

TARGET= update_timer

all:$(TARGET)

update_timer:update_timer.cpp
	$(CC) -o $@ $^

clean:
	rm -rf  $(TARGET)  *.o

.PHONY : all uart_test

