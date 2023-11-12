#! /usr/bin/bash

# dir="/media/pritam/T7/main/videos/courses/c_c++_language/c_programming_examples"
dir="."
findparms=(-name '*.mp3' -or -name '*.wav' -or -name '*.m4a' -or -name '*.mp4' -or -name '*.mkv')
(find "$dir" -maxdepth 1 "${findparms[@]}" | sort | sed "s%${dir}/%%") \
 | sk | {
	 while IFS='' read -r f; do
		 plist=("${dir}/${f}")
		 extension="${f##*.}"
	 done
		 if [ "$extension" == "mp3" ] || [ "$extension" == "m4a" ] || [ "$extension" == "m4a" ]; then
			 # ffplay -nodisp -loop -1 "${plist[@]}" >/dev/null 2>&1
			 ffplay -loop -1 "${plist[@]}" >/dev/null 2>&1
		 elif [ "$extension" == "mp4" ] || [ "$extension" == "mkv" ]; then
			 ffplay -fs -loop -1 "${plist[@]}" >/dev/null 2>&1
			 # ffplay -fs -loop -1 "${plist[@]}"
		 else
			 echo "Unsupported file extension: $extension"
		 fi
}

