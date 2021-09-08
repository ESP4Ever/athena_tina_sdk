#include <stdio.h>

/* clean up zombie child process */
void cleanChild(int signo) {
	int stat;
	while(waitpid(-1, &stat, WNOHANG) > 0);
}

/* capture signals for quitting program */
void quitProg(int signo) {
	fprintf(stdout, "Received signal %d\nkilling child processes...\n", signo);
	kill(-getpgid(getpid()), SIGTERM);
	exit(0);
}

int main()
{
	
	
	
	
	return 0;
}
