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
void formate_string(char *_content, char *_replacer);
void ch_str_replace(char *_content, const char _which, const char _what);


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

	int max = 0;
	for(int i = 1; i < argc; i++){
		int _max = strlen(argv[i]);

		if(max < _max){
			max = _max;
		}
	}

	struct stat st;

	for(int i = 1; i < argc; i++){
		char new_name[max];
		strcpy(new_name, argv[i]);
		char *file_name;

		if((file_name = strrchr(new_name, '/')) == NULL){
			file_name = &(new_name[0]);
		}
		else {
			file_name++;
		}

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

		formate_string(file_name, " ");
	}

	return 0;
}


void formate_string(char *_content, char *_replacer){
	for(int i = 0; ((_replacer[i]) != '\0'); i++){
		ch_str_replace(_content, _replacer[i], '_');
	}
	ch_str_lower(_content);
}


void ch_str_lower(char *_content){
	int i = 0;
	for(i; ((_content[i]) != '\0'); i++){
		_content[i] = tolower(_content[i]);
	}
	_content[i] = '\0';
}


void ch_str_replace(char *_content, const char _which, const char _what){
	for(int i = 0; ((_content[i]) != '\0'); i++){
		if(_content[i] == _which){
			_content[i] = _what;
		} 
	}
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
