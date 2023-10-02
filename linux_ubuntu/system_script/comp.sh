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
	# echo -e "\r|-> Compling '$file' file. <-|\r"
else
	file="$1"
fi


# Checking file type.
if [[ "$file" =~ .c$ ]]; then
	command="/usr/bin/gcc"
elif [[ "$file" =~ .cpp$ ]]; then
	command="/usr/bin/g++"
elif [[ "$file" =~ .rs$ ]]; then
	cargo run 
	exit "$?"
	# command="rustc"
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
if ! [ -d "$HOME/.user_bin" ]; then
	mkdir "$HOME/.user_bin"
fi

# Run command for 'gcc' or 'gpp' according to the file type.
"$command" "$path/$filename" -o "$HOME/.user_bin/$new_name.out"

if [[ "$?" = 0 ]]; then
	# "$path/bin/$new_name.out"
	"$HOME/.user_bin/$new_name.out"
	exit "$?"
else
	exit "$?"
fi
