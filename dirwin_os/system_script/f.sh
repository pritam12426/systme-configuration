#######!/opt/homebrew/bin/bash
#!/bin/zsh

dir="."
findparms=(-name '*.mp3' -or -name '*.mov' -or -name '*.wav' -or -name '*.m4a' -or -name '*.mp4' -or -name '*.mkv')  # The filter to find the file using `find` command

(find "$dir" -maxdepth 1 "${findparms[@]}" | sort | sed "s%${dir}/%%") \
 | sk --color=current_bg:232,info:32 | {
	 while IFS='' read -r f; do
		 plist=("${dir}/${f}")
		 extension="${f##*.}"
	 done
		 if [ "$extension" == "mp3" ] || [ "$extension" == "m4a" ] || [ "$extension" == "m4a" ]; then
			 echo "Playing 🎵 \033[1;32mMUSIC\033[0m {\033[1;31m'$plist'\033[0m} wiht ffplay...."
			 # ffplay -nodisp -loop -1 "${plist[@]}" >/dev/null 2>&1
			 ffplay -loop -1 "${plist[@]}" >/dev/null 2>&1

		 elif [ "$extension" == "mp4" ] || [ "$extension" == "mkv" ] || [ "$extension" == "mov" ];  then
			 echo "Playing 📹 \033[1;34mVIDEO\033[0m {\033[1;31m'$plist'\033[0m} wiht ffplay...."
			 # ffplay -fs -loop -1 "${plist[@]}" >/dev/null 2>&1
			 ffplay -loop -1 -sn "${plist[@]}" >/dev/null 2>&1
			 # ffplay -fs -loop -1 "${plist[@]}"
		 # else
			 # echo "Unsupported file extension: $extension"
		 fi
}

