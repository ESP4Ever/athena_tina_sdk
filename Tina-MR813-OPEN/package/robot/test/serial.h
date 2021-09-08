#ifndef SERIAL_CHANNEL_H
#define SERIAL_CHANNEL_H

#include	<stdio.h>
#include    <stdlib.h>
#include	<string.h>
#include    <unistd.h>
#include    <sys/types.h>
#include    <sys/stat.h>
#include 	<sys/time.h>
#include    <fcntl.h>
#include    <errno.h>
#include <linux/termios.h>

/*************************** Variable ******************************/
struct timeval timeout;
/*************************** Function ******************************/

int serial_open (char *dev, int nSpeed);
int serial_read(int fd, unsigned char *data_buf, int data_size );
int serial_write( int fd, unsigned char *data_buf, int data_size );
int serial_close ( int fd );
int init_serial(int fd, int nSpeed);
int set_parity(int fd,char mode);
int ioctl(int d, int request, ...);

#endif
