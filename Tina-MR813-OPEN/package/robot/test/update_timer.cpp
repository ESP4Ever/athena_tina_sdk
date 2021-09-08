#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/select.h>
#include <time.h>

/*---------test
int64_t GetTime(void)
{
	struct timespec rt;
	clock_gettime(CLOCK_MONOTONIC, &rt);

	int64_t t;
	t = (int64_t)(rt.tv_sec) * 1000000 + rt.tv_nsec / 1000;

	return t;
}
*/

int main(int argc, char **argv)
{
	struct timeval tv;
	int ret;
	char buf[64];

	if (argc < 2) {
		printf("please use: update_timer ip\n");
		return -1;
	}
	
	snprintf(buf, sizeof(buf), "ntpdate %s", argv[1]);
	printf("%s\n", buf);
	system(buf);

	while(1) {
		tv.tv_sec = 60;
		tv.tv_usec = 0;
		ret = select(0, NULL, NULL, NULL, &tv);
		if(ret == 0) {
			//test
			//snprintf(buf, sizeof(buf), "echo %ld >> ./log.txt", GetTime());
			snprintf(buf, sizeof(buf), "ntpdate %s", argv[1]);
			printf("%s\n", buf);
			system(buf);
		}
	}
	return 0;
}
