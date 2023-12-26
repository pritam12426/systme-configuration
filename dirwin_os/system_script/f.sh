#!/opt/homebrew/bin/bash

findparms=(-type f -maxdepth 1 -name '*.mp3' -or -name '*.mov' -or -name '*.wav' -or -name '*.m4a' -or -name '*.mp4' -or -name '*.mkv' -or -name '*.webm') # The filter to find the file using `find` command

if [[ "$PWD" == "$HOME/Downloads/yt_dlp"* ]]; then
	findparms+=(-mtime -9999) 
fi

command=""

(find "." "${findparms[@]}" | sed "s%./%%") | sk --color=current_bg:232,info:32 | {
	read -r sk_passed_file
	extension="${sk_passed_file##*.}"

	video_title=$(ffprobe -v error -select_streams v:0 -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 "$sk_passed_file")

	if [ -z "$video_title" ]; then
		video_title+=$sk_passed_file
	fi

	if [ "$extension" == "mp3" ] || [ "$extension" == "m4a" ] || [ "$extension" == "mav" ]; then
		command+="ffplay -loop -1 -seek_interval 5 -showmode 1"
	elif [ "$extension" == "mp4" ] || [ "$extension" == "mkv" ] || [ "$extension" == "mov" ] || [ "$extension" == "webm" ];  then
		command+="ffplay -loop -1 -sn -seek_interval 5 -volume 50 -window_title"
	else
		# echo "Error"
		echo -e "\aError: Something went wrong!"
		exit
	fi

	echo $command \"$video_title\" \"$sk_passed_file\"
	$command "$video_title" "$sk_passed_file" > /dev/null 2>&1
}
