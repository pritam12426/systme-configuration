#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdbool.h>
#include <sys/stat.h>


char *is_file(char *_path);
void ch_str_lower(char *_content);
char *get_working_dir(char *_first_name);
int max_length(char **dir_content, int len);
void formate_string(char *_content, const char *_replacers, const char _with);


int main(int argc, char *argv[]) {
	if(argc <= 1) return 1;

	char *tool_name;
	if(strrchr(argv[0], '/') != NULL){
		tool_name = strrchr(argv[0], '/');
	}
	else {
		tool_name = &(argv[0][0]);
	}

	const char *W_DIR = get_working_dir(argv[1]);
	const char *HOME = getenv("HOME");

	if(strcmp(W_DIR, HOME) == 0){
		printf("\033[1;31mSorry\033[0m [ THIS: \033[1;32m%s/\033[0m ] is home dir...\n", W_DIR);
		return 1;
	}

	if(strncmp(W_DIR, "/home/", 6) != 0){
		printf("\033[1;31mSorry\033[0m [ THIS: \033[1;32m/\033[0m ] is root dir...\n");
		return 1;
	}

	int max = max_length(argv, argc);

	struct stat st;

	for(int i = 1; i < argc; i++){
		char new_name[max];
		strcpy(new_name, argv[i]);

		stat(argv[i], &st);

		if(S_ISREG(st.st_mode)){
			printf("%d >> file { \033[1;32m%s\033[0m }-{ \033[1;31m%s\033[0m } \n", i, argv[i], new_name);
		}
		else if(S_ISDIR(st.st_mode)){
			printf("%d >> dir { \033[1;32m%s\033[0m }-{ \033[1;31m%s\033[0m } \n", i, argv[i], new_name);
		}
		else {
			printf("Error\n");
		}

	}

	return 0;
}


void formate_string(char *_content, const char *_replacers, const char _with) {
	char *file_name;

	if((file_name = strrchr(_content, '/')) == NULL){
		file_name = &(_content[0]);
	}
	else {
		file_name++;
	}

	for(int i = 0; ((file_name[i]) != '\0'); i++){
		file_name[i] = tolower(file_name[i]);
		if(file_name[i] == ' '){
			file_name[i] = '_';
		}
	}

	for(int i = 0; ((_replacers[i]) != '\0'); i++){
		for(int j = 0; ((file_name[j]) != '\0'); j++){
			if(file_name[j] == _replacers[i]){
				file_name[j] = _with;
			}
		}
	}

	short int founded = 0;

	for(int i = 0; ((file_name[i]) != '\0'); i++){
		if(file_name[i] == _with){
			founded++;
		}
	}

	short int len = strlen(file_name);

	for(int _ = 0; _ < founded; _++){
		for(int i = 0; ((file_name[i]) != '\0'); i++){
			if(file_name[i] == _with){
				for(i; i < (len + 1); i++){
					file_name[i] = file_name[(i + 1)];
				}
			}
		}
	}
}


int max_length(char **dir_content, int len){
	int max = 0;
	for(int i = 1; i < len; i++){
		int _max = strlen(dir_content[i]);

		if(max < _max){
			max = _max;
		}
	}

	return max;
}


void ch_str_lower(char *_content){
	int i = 0;

	for(i; ((_content[i]) != '\0'); i++){
		_content[i] = tolower(_content[i]);
	}
	_content[i] = '\0';
}


char *get_working_dir(char *_first_name){
	static char *PWD;
	static char another[250];

	if((PWD = strrchr(_first_name, '/')) == NULL) {
		PWD = getenv("PWD");
	}
	else {
		strcpy(another, _first_name);
		*strrchr(another, '/') = '\0';
		PWD = another;
	}

	return PWD;
}

char *is_file(char *_path) {
	//  TODO: Add a function for testing wether passed path is file of folder :)
}
