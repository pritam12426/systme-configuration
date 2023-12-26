#!/opt/homebrew/bin/bash

findparms=(-type f -maxdepth 1 -name '*.mp3' -or -name '*.mov' -or -name '*.wav' -or -name '*.m4a' -or -name '*.mp4' -or -name '*.mkv' -or -name '*.webm') # The filter to find the file using `find` command
command=""

(find "." "${findparms[@]}" | sort | sed "s%./%%") | sk --color=current_bg:232,info:32 | {
	read -r sk_passed_file
	extension="${sk_passed_file##*.}"

	# video_title=$(ffprobe -v error -select_streams v:0 -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 "$sk_passed_file")

	if [ "$extension" == "mp3" ] || [ "$extension" == "m4a" ] || [ "$extension" == "mav" ]; then
		command+="ffplay -loop -1 -seek_interval 5"
	elif [ "$extension" == "mp4" ] || [ "$extension" == "mkv" ] || [ "$extension" == "mov" ] || [ "$extension" == "webm" ];  then
		command+="ffplay -loop -1 -sn -seek_interval 5 -volume 50"
	else
		echo "Error"
		exit 1
	fi

	echo $command \"$sk_passed_file\"
	$command "$sk_passed_file" > /dev/null 2>&1
}

