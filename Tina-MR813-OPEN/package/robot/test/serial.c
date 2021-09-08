#include "serial.h"
#include <sys/epoll.h>

int init_serial(int fd, int baud) {
	printf("[RT SERIAL] Configuring serial device...\n");
	struct termios2 tty;

	ioctl(fd, TCGETS2, &tty);
	tty.c_cflag &= ~CBAUD;
	tty.c_cflag |= BOTHER;
	tty.c_ispeed = baud;
	tty.c_ospeed = baud;

	tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
                | INLCR | IGNCR | ICRNL | IXON);
	tty.c_oflag &= ~OPOST;
	tty.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
	tty.c_cflag &= ~(CSIZE | PARENB);
	tty.c_cflag |= PARENB;
	tty.c_cflag &= ~PARODD;
	tty.c_cflag |=
	tty.c_cflag |= CS8;

	// tty.c_cflag = (tty.c_cflag & ~CSIZE) | CS8;  // 8-bit chars
	// disable IGNBRK for mismatched speed tests; otherwise receive break
	// as \000 chars
	// tty.c_iflag &= ~IGNBRK;  // disable break processing
	// tty.c_lflag = 0;         // no signaling chars, no echo,
	// // no canonical processing
	// tty.c_oflag = 0;      // no remapping, no delays
	tty.c_cc[VMIN] = 0;//1;   // read doesn't block
	tty.c_cc[VTIME] = 1;  // 0.5 seconds read timeout

	// tty.c_iflag &= ~(IXON | IXOFF | IXANY);  // shut off xon/xoff ctrl

	// tty.c_cflag |= (CLOCAL | CREAD);  // ignore modem controls,
	// // enable reading
	// // tty.c_cflag &= ~(PARENB | PARODD);      // shut off parity
	// tty.c_cflag |= PARENB;
	// tty.c_cflag &= ~CSTOPB;
	// tty.c_cflag &= ~CRTSCTS;
	// cfmakeraw(&tty);

	if (ioctl(fd, TCSETS2, &tty))
	{
		printf("TCSETS2 fail\n");
		return -1;
	}

	printf("actual speed reported %d\n", tty.c_ospeed);

	return 0;
}

int serial_open(char *dev, int nSpeed)
{
	int	fd ,ret;

	chmod(dev, 777);

	fd = open(dev, O_RDWR | O_NOCTTY);
	if (fd == -1)
	{	
		return -1;
	}

	ret = init_serial(fd, nSpeed);
	if (ret == -1)
	{
		printf("Serial init failed!\n");
		return -1;
	}

	return fd;
}

int serial_read(int fd, unsigned char *data_buf, int data_size )
{
	int ret;
	fd_set nfds;

	FD_ZERO(&nfds);
	FD_SET(fd,&nfds);
    timeout.tv_sec = 0;
	timeout.tv_usec= 100000;

	switch (select(fd + 1, &nfds, NULL, NULL, &timeout))
	{
        case -1:
                perror("Serial read\n");
                return -1;
                break;
        case 0: 
                return -1;
                break;
        default:    
                if (FD_ISSET(fd, &nfds))
                {
                    ret = read(fd, data_buf, data_size);
                    printf("%s\n", data_buf);
                    break;
                }                
	}

	return ret;
}

int serial_write( int fd, unsigned char *data_buf, int data_size )
{
    int ret ;
    ret = write(fd, data_buf, data_size);
    if (ret == -1)
    {
        perror("Serial write");
        return -1;
    }

    return ret;
}

int serial_close ( int fd )
{
    int ret ;
    ret = close(fd);
    if (ret == -1)
    {
        perror("Serial close");
        return -1;
    }

    return ret;
}
