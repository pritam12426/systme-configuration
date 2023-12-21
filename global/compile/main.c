#include <time.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <sys/stat.h>


void ch_str_lower(char *_content);
bool str_ends_with(char *_content, char *_ends);
void ch_str_replace(char *_content, const char _which, const char _what);
void run(time_t _old_time, char *_command, short int *_return_value, short int _type);


int main(int argc, char *argv[]) {
	if(argc != 2) return 2;

	struct stat st;
	if(stat(argv[1], &st) != false) {
		printf("\033[1;31mFILE NOT FOUND\033[0m: { \033[1;36m%s\033[0m }\n", argv[1]);
		return 1;
	}

	time_t old = clock();
	short int return_value = 0;
	short int len_argv = (strlen(argv[1]) + 1);

	if(str_ends_with(argv[1], ".py")) {
		char _command[len_argv + 9];

		#ifdef linux
			sprintf(_command, "%s %s", "python3", argv[1]);
		#elif __APPLE__
			sprintf(_command, "%s %s", "python3", argv[1]);
		#elif __WIN32
			sprintf(_command, "%s %s", "python", argv[1]);
		#else
			printf("\033[1;31mUNSUPPORTED SYSTEM\033[0m:(\n");
			return 1;
		#endif

		run(old, _command, &return_value, 1);
		return return_value;
	}
	else if(str_ends_with(argv[1], ".js")) {
		char _command[len_argv + 9];
		sprintf(_command, "%s %s", "node", argv[1]);
		run(old, _command, &return_value, 1);
		return return_value;
	}

	return_value = -1;
	char path_separator;
	char *file_extension;

	#ifdef linux
		path_separator = '/';
		file_extension = ".out";
	#elif __APPLE__
		path_separator = '/';
		file_extension = ".out";
	#elif __WIN32
		path_separator = '\\';
		file_extension = ".exe";
	#else
		printf("\033[1;31mUNSUPPORTED SYSTEM\033[0m:(\n");
		return 1;
	#endif

	char *file_name;

	if((file_name = strrchr(argv[1], path_separator)) == NULL) {
		file_name = &(argv[1][0]);
	}
	else {
		file_name++;
	}

	short int len_file_name = strlen(file_name) + 1;
	char actual_file_name[len_file_name];
	strcpy(actual_file_name, file_name);

	char *temp_dir;

	#ifdef linux
		temp_dir = "/tmp/";
	#elif __APPLE__
		temp_dir = "~/Library/Caches/";
	#elif __WIN32
		temp_dir = "C:\\WINDOWS\\Temp\\";
	#else
		printf("\033[1;31mUNSUPPORTED SYSTEM\033[0m:(\n");
		return 1;
	#endif

	short int len_temp_dir = strlen(temp_dir);
	char _command[len_argv + len_file_name + len_temp_dir + 18];

	ch_str_lower(actual_file_name);
	ch_str_replace(actual_file_name, '.', '-');

	if(str_ends_with(argv[1], ".c")){
		sprintf(_command, "gcc %s %s %s%s%s", argv[1], "-o", temp_dir, actual_file_name, file_extension);
	}
	else if(str_ends_with(argv[1], ".cpp")){
		sprintf(_command, "g++ %s %s %s%s%s", argv[1], "-o", temp_dir, actual_file_name, file_extension);
	}
	else if(str_ends_with(argv[1], ".rs")){
		sprintf(_command, "rustc %s %s %s%s%s", argv[1], "-o", temp_dir, actual_file_name, file_extension);
	}
	else if(str_ends_with(argv[1], ".java")){
		sprintf(_command, "javac %s %s %s%s%s", argv[1], "-o", temp_dir, actual_file_name, file_extension);
		// TODO: Write the logic for compiling the '.java' files :)..
	}
	else{
		printf("\033[1;31mUNSUPPORTED FILE TYPE\033[0m: { \033[1;36m%s\033[0m }.\n", file_name);
		return 2;
	}

	printf("[\033[1;35mTRYING TO COMPILE\033[0m] { \033[1;36m%s\033[0m }\n", _command);
	return_value = system(_command);

	if(return_value == 0) {
		char another_command[len_temp_dir + len_file_name];
		sprintf(another_command, "%s%s%s", temp_dir, actual_file_name, file_extension);
		printf("[\033[1;35mRUNNING\033[0m] { \033[1;36m%s\033[0m }\n", another_command);
		// return_value = system(another_command);
		run(old, another_command, &return_value, 2);
	}

	return return_value;
}


void run(time_t _old_time, char *_command, short int *_return_value, short int _type){
	if(_type == 1){
		/* This check will encounter when the file type is (.py, .js) */
		*_return_value = system(_command);
		if(*_return_value == 0){
			printf("[\033[1;32mDONE\033[0m] exited with (\033[1;34mcode = 0\033[0m) in (\033[1;35m%f\033[0m seconds)\n", ((double)(clock() - _old_time)) / CLOCKS_PER_SEC);
		}
		else {
			printf("[\033[1;31mDONE WITH AN ERROR\033[0m] exited with (\033[1;34mcode = %d\033[0m) in (\033[1;35m%lf\033[0m seconds)\n", *_return_value, ((double)(clock() - _old_time)) / CLOCKS_PER_SEC);
		}
	}
	else if(_type == 2){
		/* This check will encounter when the file type is (.js, .rs, .c, .cpp) */
		if(*_return_value == 0){
			*_return_value = system(_command);
			printf("[\033[1;32mDONE\033[0m] exited with (\033[1;34mcode = 0\033[0m) in (\033[1;35m%f\033[0m seconds)\n", ((double)(clock() - _old_time)) / CLOCKS_PER_SEC);
		}
		else {
			printf("[\033[1;31mDONE WITH AN ERROR\033[0m] exited with (\033[1;34mcode = %d\033[0m) in (\033[1;35m%lf\033[0m seconds)\n", *_return_value, ((double)(clock() - _old_time)) / CLOCKS_PER_SEC);
		}
	}
}


void ch_str_lower(char *_content) {
	for(int i = 0; ((_content[i]) != '\0'); i++){
		_content[i] = tolower(_content[i]);
	}
}


void ch_str_replace(char *_content, const char _which, const char _what) {
	int _len = strlen(_content);

	for(int i = _len; i; i--) {
		if(_content[_len] == _which){
			_content[_len] = _what;
			break;
		}
	}
}


bool str_ends_with(char *_content, char *_ends) {
	int _len_ends = strlen(_ends);
	int _len_content = strlen(_content);

	if(_len_ends > _len_content) {
		return false;
	}

	for(int i = 0; i < _len_ends; i++) {
		if(_content[(_len_content - i - 1)] != _ends[(_len_ends - i - 1)]){
			return false;
		}
	}

	return true;
}
