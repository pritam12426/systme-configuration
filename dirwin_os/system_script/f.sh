#!/opt/homebrew/bin/bash

findparms=(-type f -maxdepth 1 -name '*.mp3' -or -name '*.mov' -or -name '*.wav' -or -name '*.m4a' -or -name '*.mp4' -or -name '*.mkv' -or -name '*.webm') # The filter to find the file using `find` command
command=""

(find "." "${findparms[@]}" | sort | sed "s%./%%") | sk --color=current_bg:232,info:32 | {
	IFS='' read -r f
	extension="${f##*.}"

	if [ "$extension" == "mp3" ] || [ "$extension" == "m4a" ] || [ "$extension" == "mav" ]; then
		command+="ffplay -loop -1 "${f}""
	elif [ "$extension" == "mp4" ] || [ "$extension" == "mkv" ] || [ "$extension" == "mov" ] || [ "$extension" == "webm" ];  then
		command+="ffplay -loop -1 -sn "${f}""
	else
		echo "Error"
		exit
	fi

	echo $command
	$command > /dev/null 2>&1
}
