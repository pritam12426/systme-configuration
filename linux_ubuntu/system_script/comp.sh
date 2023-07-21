#!/bin/bash

# Giving default file path.
if [[ $# -eq 0 ]]; then
	if [ -f "main.c" ]; then
		file="main.c"
	elif [ -f "main.cpp" ]; then
		file="main.cpp"
	elif [ -f "main.rs" ]; then
		file="main.rs"
	else
		echo "comp: missing operand"
		exit 1
	fi
	echo -e "|-> Compling '$file' file. <-|\n"
else
	file="$1"
fi


# Checking file type.
if [[ "$file" =~ .c$ ]]; then
	command="/usr/bin/gcc"
elif [[ "$file" =~ .cpp$ ]]; then
	command="/usr/bin/cpp"
elif [[ "$file" =~ .rs$ ]]; then
	command="/usr/bin/rustc"
elif [[ "$file" =~ .py$ ]]; then
	python3 "$file"
	exit "$?"
elif [[ "$file" =~ .sh$ ]]; then
	"./$file"
	exit "$?"
else
	root_data=$(cat "$file" | head -n 1 | cut -c 3-)

	if [[ -f "$root_data" ]]; then
		$root_data "$file"
		exit "$?"
	else
		echo "| '$file' Unknown file type."
		exit 1
	fi
fi

filename=$(basename "$file")
path=$(dirname "$file")

# new_name="${file%.*}"
new_name="${filename//./-}"

# Make bin dir if it is not present.
if ! [ -d "$path/bin" ]; then
	mkdir "$path/bin"
fi

# Run command for 'gcc' or 'gpp' according to the file type.
"$command" "$path/$filename" -o "$path/bin/$new_name.out"

if [[ "$?" = 0 ]]; then
	"$path/bin/$new_name.out"
	exit "$?"
else
	exit "$?"
fi
