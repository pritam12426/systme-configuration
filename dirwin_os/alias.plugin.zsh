# This file conten only aliases for "zsh/bash"
# linux ls color theme
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Some more alies
alias cp="cp -ip"
alias mv="mv -i"
alias du="du -h"

# For neo nvim
alias erc="nvim ~/.zshrc"
alias evrc="sudo vim /etc/vim/vimrc"
alias enrc="nvim ~/.config/nvim/init.vim"
alias eza="nvim ~/.oh-my-zsh/plugins/alias/alias.plugin.zsh"

# Git alias
alias ga='git add'
alias gst='git status'
alias gc='git commit'
alias gs='git status'
alias gcm='git commit -m'
alias gaa='git add --all'
alias gp='git push origin'
alias gss='git status --short'
alias gpmain='git push origin main'
alias githubconfig="git config user.name 'Pritam' && git config user.email '84720825+pritam12426@users.noreply.github.com' && git config tag.gpgsign true"

# For change dir()
alias hdir="cd ~/Developer/html/"
alias rdir="cd ~/Developer/rust/"
alias spdir="cd ~/Developer/system_script/"
alias cdir="cd ~/Developer/c_lang/practic/"
alias ldir="cd ~/Developer/c_lang/leedcode/"
alias pydir="cd ~/Developer/python/practic/"
alias gdir="cd ~/Developer/git_repositories/"
alias tdir="cd /Volumes/T7/main/videos/courses/"
alias cpdir="cd ~/Developer/cpp_lang/practic"
alias pdir="cd $present_working_project_directory"

# color for man page
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# System scripts
alias z="zed"
alias tree="tre -e"
alias mvin="mvim -O"
alias python="python3"
alias lfind="alias | grep -i "
alias nq="networkquality -s"
alias hc="cat /dev/null > ~/.zsh_history"
alias gfind="ls -aF --color=auto | grep -i"
alias lh="ls -aF --color=auto | egrep '^\.'"
alias envpath="echo $PATH | tr ':' '\n' | bat"
alias findds="find . -type f -name '.DS_Store'"
alias scrcpy_r="scrcpy -r ~/Movies/screen_cast/scrcpy_$(date +'%Y-%m-%d_%H-%M-%S').mp4"
alias removeds="echo 'removed:' && findds && find . -name '.DS_Store' -exec rm -f {} +"
alias vsdebug="mkdir -p '.vscode' && curl 'https://raw.githubusercontent.com/pritam12426/systme-configuration/main/global/vscode/launch.json' -o launch.json"

# exiftool
alias exfchimg="exf -Picture"
alias exfcpy="exf -TagsFromFile"
alias exfimg="exiftool -b -Picture -W%d%f_cover.jpg"
alias exf="exiftool -sort -P -overwrite_original_in_place"

# yt-dlp
alias yt-dlpwd="yt-dlp -o '%(title)s.%(ext)s'"
alias yt-dlpx="yt-dlp -o '%(extractor)s-%(title)s.%(ext)s' -f 'best/bestvideo*+bestaudio*'"
alias yt-dlpp="yt-dlp -o '~/Downloads/yt_dlp/youtube_playlist/%(playlist)s-%(uploader)s/%(playlist_index)s-%(title)s.%(ext)s'"
alias short="yt-dlp --no-embed-thumbnail --no-mtime -o '~/Downloads/yt_dlp/short_vidoes/%(extractor_key)s-%(channel)s-%(id)s.%(ext)s' -f 'best/bestvideo*+bestaudio*'"
alias insta="yt-dlp --no-mtime -o '~/Downloads/yt_dlp/short_vidoes/%(extractor_key)s-%(channel)s-%(id)s-%(uploader_id)s.%(ext)s' -f 'best/bestvideo*+bestaudio*' --cookies-from-browser 'firefox'"

# NNN file manager
export NNN_COLORS="5236"
export NNN_OPTS="RAUNdxe"
export NNN_OPENER="qqqq"
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
export NNN_PLUG='g:gitroot;c:cbcopy-mac;r:-!renamepwd "$nnn";e:!|exiftool "$nnn"'
export NNN_BMS="d:~/Developer/;s:/Volumes/T7/main/videos/;y:~/Downloads/yt_dlp/;m:~/Music/local/"
export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"

# nnn filemanger cd on quit
nnn ()
{
	# Block nesting of nnn in subshells
	[ "${NNNLVL:-0}" -eq 0 ] || {
		echo "nnn is already running"
		return
	}

	export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
	command nnn "$@"

	[ ! -f "$NNN_TMPFILE" ] || {
		. "$NNN_TMPFILE"
		rm -f "$NNN_TMPFILE" > /dev/null
	}
}

LANG="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_ALL=

function pathcp {
	# local file="${1:-.}"
	local file="${1:-}"
	[[ $file = /* ]] || file="$PWD/$file"
	echo "${file:a}" | tr  '\n' ' ' | pbcopy
}

#  For commit the commit with gpg
GPG_TTY=$(tty)
export GPG_TTY



# IP / macId alias and functions
alias ipinfo="curl https://raw.githubusercontent.com/jarun/nnn/master/plugins/ipinfo 2> /dev/null | bash"
alias wanip="curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'"  # will print the loal ipv4 in termial.
alias macid="ifconfig -a | grep ether | grep -oE '([0-9][0-9]:[a-z][0-9]:[a-z][a-z]:[a-z][a-z]:[0-9][0-9]:[0-9][0-9])' | head -n 1"  # will print the return the macid of the computer
alias lanip="ifconfig -a | egrep -A 7 '^en0' | grep inet | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | head -n 1"
