#!/bin/bash

# Giving default file path.

if [[ $# -eq 0 ]]; then
	if [ -f "main.c" ]; then
		file="main.c"
		echo "compiling main.c ..."

	elif [ -f "main.cpp" ]; then
		file="main.cpp"
		echo "compiling main.cpp ..."

	elif [ -f "main.py" ]; then
		file="main.py"
		echo "compiling main.py ..."

	elif [ -f "main.rs" ]; then
		file="main.rs"
		echo "compiling main.rs ..."

	else
		echo "comp: missing operand"
		exit 1
	fi
else
	file="$1"
fi


GNU_version=""
path=$(dirname "$file")

# Checking file type.
if [[ "$file" =~ .c$ ]]; then
	GNU_version="-std=c2x"
	command="clang"

elif [[ "$file" =~ .cpp$ ]]; then
	command="clang++"
	GNU_version="-std=c++20"

elif [[ "$file" =~ .rs$ ]]; then
	cargo run
	exit "$?"

elif [[ "$file" =~ makefile$ ]]; then
	make -C $path -f $file
	exit "$?"

elif [[ "$file" =~ .html$ ]]; then
	open "$file"
	exit 0

elif [[ "$file" =~ .py$ ]]; then
	python3 "$file"
	exit "$?"

elif [[ "$file" =~ .java$ ]]; then
	java "$file"
	exit "$?"

elif [[ "$file" =~ .js$ ]]; then
	node "$file"
	exit "$?"

elif [[ "$file" =~ .sh$ ]]; then
	"$file"
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

# new_name="${file%.*}"
new_name="${filename//./-}"

# Make bin dir if it is not present.

# Run command for 'gcc' or 'gpp' according to the file type.
("$command" "$GNU_version" "$path/$filename" -o "$TMPDIR$new_name.out")

if [[ "$?" = 0 ]]; then
	"$TMPDIR$new_name.out"
	exit "$?"
else
	exit "$?"
fi
