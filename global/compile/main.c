#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/stat.h>
#include "./lib/user_function.h"


#if defined(__APPLE__) || defined(linux)
	#define PYTHON "python3"
#elif defined(__WIN32)
	#define PYTHON "python"
#endif


#if defined(__APPLE__) || defined(linux)
	#define PATH_SEPARATOR '/'
	#define FILE_EXTENSION ".out"
#elif defined(__WIN32)
	#define PATH_SEPARATOR '\\'
	#define FILE_EXTENSION ".exe"
#endif


static char *TEMP_DIR;


int main(int argc, char *argv[]) {
	if(argc != 2) return 2;

	struct stat st;
	if (stat(argv[1], &st) != false) {
		printf("\033[1;31mFILE NOT FOUND\033[0m: { \033[1;36m%s\033[0m }\n", argv[1]);
		return 1;
	}

	size_t len_argv = (strlen(argv[1]) + 1);

	if (strEndWith(argv[1], ".py")) {
		char python_command[len_argv + 9];
		snprintf(python_command, sizeof(python_command), "%s %s", PYTHON, argv[1]);
		printf("[\033[1;35mRUNNING\033[0m] { \033[1;36m%s\033[0m }\n", python_command);
		return system(python_command);
	}
	else if (strEndWith(argv[1], ".js")) {
		char JScommand[len_argv + 5];
		snprintf(JScommand, sizeof(JScommand), "%s %s", "node", argv[1]);
		printf("[\033[1;35mRUNNING\033[0m] { \033[1;36m%s\033[0m }\n", JScommand);
		return system(JScommand);
	}

	char *file_name;

	if((file_name = strrchr(argv[1], PATH_SEPARATOR)) == NULL) {
		file_name = &(argv[1][0]);
	}
	else {
		file_name++;
	}

	#ifdef linux
		TEMP_DIR = getenv("TMPDIR");
	#elif __APPLE__
		TEMP_DIR = getenv("TMPDIR");
	#elif __WIN32
		TEMP_DIR = "C:\\WINDOWS\\Temp\\";
	#else
		printf("\033[1;31mUNSUPPORTED SYSTEM\033[0m:(\n");
		return 1;
	#endif

	size_t len_file_name = strlen(file_name) + 1;
	char actual_file_name[len_file_name];
	strcpy(actual_file_name, file_name);
	
	chStrLower(actual_file_name);

	chStrReplace(actual_file_name, ' ', '_');
	chStrReplace(actual_file_name, '.', '_');

	size_t len_temp_dir = strlen(TEMP_DIR);
	char _command[len_argv + len_file_name + len_temp_dir + 18];


	if(strEndWith(argv[1], ".c")){
		sprintf(_command, "gcc %s %s %s%s%s", argv[1], "-o", TEMP_DIR, actual_file_name, FILE_EXTENSION);
	}
	else if(strEndWith(argv[1], ".cpp")){
		sprintf(_command, "g++ %s %s %s%s%s", argv[1], "-o", TEMP_DIR, actual_file_name, FILE_EXTENSION);
	}
	else if(strEndWith(argv[1], ".rs")){
		sprintf(_command, "rustc %s %s %s%s%s", argv[1], "-o", TEMP_DIR, actual_file_name, FILE_EXTENSION);
	}
	else if(strEndWith(argv[1], ".java")){
		sprintf(_command, "javac %s %s %s%s%s", argv[1], "-o", TEMP_DIR, actual_file_name, FILE_EXTENSION);
		// TODO: Write the logic for compiling the '.java' files :)..
	}
	else{
		printf("\033[1;31mUNSUPPORTED FILE TYPE\033[0m: { \033[1;36m%s\033[0m }.\n", file_name);
		return 2;
	}
	int return_value = -1;

	printf("[\033[1;35mTRYING TO COMPILE\033[0m] { \033[1;36m%s\033[0m }\n", _command);
	return_value = system(_command);

	if (return_value == 0) {
		char another_command[len_temp_dir + len_file_name];
		sprintf(another_command, "%s%s%s", TEMP_DIR, actual_file_name, FILE_EXTENSION);
		printf("[\033[1;35mRUNNING\033[0m] { \033[1;36m%s\033[0m }\n", another_command);

		clock_t start_time = clock();
		if(system(another_command) == 0) {
			double elapsed_time_ms = ((double)(clock() - start_time) / CLOCKS_PER_SEC) * 1000;
			printf("[FINISHED IN COLOR \033[1;32m%f\033[0m ms]\n", elapsed_time_ms);
		}
		else {
			double elapsed_time_ms = ((double)(clock() - start_time) / CLOCKS_PER_SEC) * 1000;
			printf("[FINISHED IN COLOR \033[1;31m%f\033[0m ms]\n", elapsed_time_ms);
			return 1;
		}
	}

	return 0;
}
