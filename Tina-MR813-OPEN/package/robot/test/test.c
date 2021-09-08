#include <stdio.h>
#include <unistd.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <iostream>
#include <signal.h>

using namespace std;

void signal_handler(int signo) {
	fprintf(stderr, "signo: %d\n", signo);
}

int main()
{
	pid_t pid = fork();

	//char stdout_path[100] = "\0";
	//char stderr_path[100] = "\0";
	//char time_string[20]= "\0";
	
	char stdout_path[100] = "";
	char stderr_path[100] = "";
	char time_string[20];
	std::string log_path = "/mnt/UDISK";
	std::string name = "manager_log";
	
	time_t start_time = time(NULL);
	fprintf(stdout, "Program started on %s\n", ctime(&start_time));
	fprintf(stderr, "Program started on %s\n", ctime(&start_time));
	/* capture signals */
	signal(SIGCHLD, signal_handler);
	signal(SIGTERM, signal_handler);
	signal(SIGINT, signal_handler);

	if (pid < 0) {
		perror("fork\n");
	} else if (pid == 0) {
		time_t starttime = time(NULL);
		struct tm *timeinfo = localtime(&starttime);
		strftime(time_string, sizeof(time_string), "%Y%m%d_%H%M%S", timeinfo);
		snprintf(stdout_path, 100, "%s/%s/stdout/%s.log", log_path, name, time_string);
		snprintf(stderr_path, 100, "%s/%s/stderr/%s.log", log_path, name, time_string);
		
		//printf("%s %s\n", stdout_path, stderr_path);
		
		int stdout_fd = open(stdout_path, O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR);
		int stderr_fd = open(stderr_path, O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR);

		if(stdout_fd < 0 || stderr_fd < 0) {
			perror("Cannot create log file");

			/* redirect program's stdout and stderr to our custom file descriptor */
		} else {
			dup2(stdout_fd, STDOUT_FILENO);
			dup2(stderr_fd, STDERR_FILENO);
			close(stdout_fd);
			close(stderr_fd);
		}
			/*
			while (1) {
				perror("child process!!!!\n");
				std::cerr << "This is child process cerr..." << endl;
				fprintf(stderr, "This is child process stderr\n");
				
			}*/
	} else {
		/*while (1)
		{
			perror("father process!!!!\n");
			std::cerr << "This is father process cerr..." << endl;
			fprintf(stderr, "This is father process stderr\n");
		}*/
	}
	return 0;
}
