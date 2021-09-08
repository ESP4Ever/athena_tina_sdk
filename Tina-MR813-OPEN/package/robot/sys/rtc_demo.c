#include <stdio.h>         /*标准输入输出定义*/
#include <stdlib.h>        /*标准函数库定义*/
#include <unistd.h>        /*Unix 标准函数定义*/
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>         /*文件控制定义*/
#include <sys/ioctl.h>
#include <linux/rtc.h>     /*RTC支持的CMD*/
#include <errno.h>         /*错误号定义*/
#include <sys/time.h>
#include <string.h>

#define RTC_DEVICE_NAME    "/dev/rtc0"

int set_rtc_timer(int fd, int year, int mon, int day,
			int hour, int min, int sec)
{
	struct rtc_time rtc_tm = {0};
	struct rtc_time rtc_tm_temp = {0};

	rtc_tm.tm_year = year - 1900;      /*需要设置的年份，需要减1900*/
	rtc_tm.tm_mon = mon -1;               /*需要设置的月份，需要确保在0-11范围*/
	rtc_tm.tm_mday = day;             /*需要设置的日期*/
	rtc_tm.tm_hour = hour;             /*需要设置的时间*/
	rtc_tm.tm_min = min;               /*需要设置的分钟时间*/
	rtc_tm.tm_sec = sec;               /*需要设置的秒数*/

	/*设置RTC时间*/
	if (ioctl(fd, RTC_SET_TIME, &rtc_tm) < 0) {
		printf("RTC_SET_TIME failed\n");
		return -1;
	}

	/*获取RTC时间*/
	if (ioctl(fd, RTC_RD_TIME, &rtc_tm_temp) < 0) {
		printf("RTC_RD_TIME failed\n");
		return -1;
	}

	printf("RTC_RD_TIME return %04d-%02d-%02d %02d:%02d:%02d\n",
			rtc_tm_temp.tm_year + 1900, rtc_tm_temp.tm_mon + 1, rtc_tm_temp.tm_mday,
			rtc_tm_temp.tm_hour, rtc_tm_temp.tm_min, rtc_tm_temp.tm_sec);
	
	return 0;
} 

int set_rtc_alarm(int fd)
{
	struct rtc_time rtc_tm = {0};
	struct rtc_time rtc_tm_temp = {0};
	
	rtc_tm.tm_year = 0;  /*闹钟忽略年设置*/
	rtc_tm.tm_mon = 0;   /*闹钟忽略月设置*/
	rtc_tm.tm_mday = 0;  /*闹钟忽略日期设置*/
	rtc_tm.tm_hour = 10; /*需要设置的时间*/
	rtc_tm.tm_min = 12;  /*需要设置的分钟时间*/
	rtc_tm.tm_sec = 30;  /*需要设置的秒数*/
	
	/* set alarm time */
	if (ioctl(fd, RTC_ALM_SET, &rtc_tm) < 0) {
		printf("RTC_ALM_SET failed\n");
		return -1;
	}
	
	if (ioctl(fd, RTC_AIE_ON) < 0) {
		printf("RTC_AIE_ON failed!\n");
		return -1;
	}
	
	if (ioctl(fd, RTC_ALM_READ, &rtc_tm_temp) < 0) {
		printf("RTC_ALM_READfailed\n");
		return -1;
	}

	printf("RTC_ALM_READ return %04d-%02d-%02d %02d:%02d:%02d\n",
			rtc_tm_temp.tm_year + 1900, rtc_tm_temp.tm_mon + 1, rtc_tm_temp.tm_mday,
			rtc_tm_temp.tm_hour, rtc_tm_temp.tm_min, rtc_tm_temp.tm_sec);

	return 0;
}

int main(int argc, char *argv[])
{
	int fd;
	int ret;

	/*open rtc device*/
	fd = open(RTC_DEVICE_NAME, O_RDWR);
	if (fd < 0) {
		printf("open rtc device %s failed\n", RTC_DEVICE_NAME);
		return -ENODEV;
	}
	
	/*设置RTC时间*/
	ret = set_rtc_timer(fd, atoi(argv[1]), atoi(argv[2]), atoi(argv[3]),
			atoi(argv[4]), atoi(argv[5]), atoi(argv[6]));
	if (ret < 0) {
		printf("set rtc timer error\n");
		return -EINVAL;
	}
	
	/*设置闹钟*/ 
#if 0 //关闭
	ret = set_rtc_alarm(fd);
	if (ret < 0) {
		printf("set rtc alarm error\n");
		return -EINVAL;
	}
#endif
	close(fd);
	return 0;
}

