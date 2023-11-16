#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <sys/stat.h>


bool is_char_in(char *_content, char _what){
	for(int i = 0; ((_content[i]) != '\0'); i++){
		if(_content[i] == _what) return true;
	}
	return false;
}


bool str_ends_with(char *_content, char *_ends){
	int _len_ends = strlen(_ends);
	int _len_content = strlen(_content);

	if(_len_ends > _len_content){
		return false;
	}

	for(int i = 0; i < _len_ends; i++){
		if(_content[(_len_content - i - 1)] != _ends[(_len_ends - i - 1)]){
			return false;
		}
	}

	return true;
}


bool str_starts_with(char *_content, char *_starts){
	int _len_starts = strlen(_starts);
	int _len_content = strlen(_content);

	if(_len_starts > _len_content){
		return false;
	}

	for(int i = 0; i < _len_starts; i++){
		if(_content[i] != _starts[i]) return false;
	}

	return true;
}


int main(int argc, char *argv[]) {
	if(argc != 2) return 2;

	struct stat st;
	if(stat(argv[1], &st) != 0){
		printf("{ %s } file not found\n", argv[1]);
		return 1;
	}

	short int af_path_len = (strlen(argv[1]) + 1);

	if(str_ends_with(argv[1], ".py")){
		char _command[af_path_len + 9];
		sprintf(_command, "%s %s", "python3", argv[1]);
		return system(_command);
	}

	char actual_file_path[af_path_len];
	strcpy(actual_file_path, argv[1]);


	char *file_name = strrchr(argv[1], '/') + 1;

	short int _x = strlen(file_name);
	char _command[af_path_len + _x + 19];
	short int error_code = -1;

	if(str_ends_with(argv[1], ".c")){
		sprintf(_command, "%s %s %s %s%s%s", "gcc", argv[1], "-o", "/tmp/", file_name, ".out");
		printf("%s\n", _command);
		error_code = system(_command);
	}
	else if(str_ends_with(argv[1], ".cpp")){
		sprintf(_command, "%s %s %s %s%s%s", "gpp", argv[1], "-o", "/tmp/", file_name, ".out");
		printf("%s\n", _command);
		error_code = system(_command);
		
	}
	else{
		printf("Unsupported file type { %s }.\n", file_name);
		return 2;
	}

	if(error_code == 0){
		char another_command[_x + 6];
		sprintf(another_command, "/tmp/%s.out",file_name );
		printf("%s\n", another_command);
		return system(another_command);
	}

	return error_code;
}
