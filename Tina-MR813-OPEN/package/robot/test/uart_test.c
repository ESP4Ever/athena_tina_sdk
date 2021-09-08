#include "serial.h"
#include<stdio.h>      /*标准输入输出定义*/    
#include<stdlib.h>     /*标准函数库定义*/    
#include<unistd.h>     /*Unix 标准函数定义*/    
#include<sys/types.h>     
#include<sys/stat.h>       
#include<fcntl.h>      /*文件控制定义*/        
#include<errno.h>      /*错误号定义*/    
#include<string.h>

int main(int argc, char **argv)    
{
	int fd = -1;           
    int ret = 0;    
    int len = 0;                            
    int i = 0;   
    int hex_num = 0;  
    char *p =NULL;   
    char tmp_str[64] ={0};         
    unsigned char send_buf[256] = {'\0'};
    unsigned char recv_buf[256] = {'\0'};

    if(argc < 2)
    {    
        printf("Usage: %s /dev/ttySn \n",argv[0]);
        return -1;    
    }

	fd = serial_open(argv[1], 100000);
	if (fd < 0)
	{
		perror("open");
		serial_close(fd);
		return -1;
	}
	else
	{
		printf("open %s ok\r\n",argv[1]);
	}

#if 0 //自发自收测试
    len=strlen(argv[2]);
    printf("send hex_str len:%d\r\n", len);

    if (len%2 != 0)
    {
		 printf("send hex_str len not even number!!!\r\n");
		 return -1;
	}

    p=argv[2];
    printf("send hex str:%s\r\n", p);
    
    strncpy(send_buf, p, len);

	ret=serial_write(fd, send_buf, len);
	printf("send_buf:%s\n", send_buf);
	printf("send num=%d\r\n", ret);
#endif

	ret=serial_read(fd, recv_buf, 4);

	printf("recv num=%d\r\n", ret);

	serial_close(fd);
	printf("close ok\r\n");
	return 0;
}
