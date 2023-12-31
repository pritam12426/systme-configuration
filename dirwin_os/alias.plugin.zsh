# This file conten only aliases for "zsh/bash"

# linux ls color theme
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# For neo nvim
alias erc="nvim ~/.zshrc"
alias evrc="sudo vim /etc/vim/vimrc" 
alias enrc="nvim ~/.config/nvim/init.vim" 
alias eza="nvim ~/.oh-my-zsh/plugins/alias/alias.plugin.zsh"

# Git alias
alias ga='git add'
alias gaa='git add --all'
alias gst='git status'
alias gc='git commit'
alias gs='git status'
alias gss='git status --short'
alias gpmain='git push origin main'
alias gp='git push origin'
alias githubconfig="git config user.name 'Pritam' && git config user.email '84720825+pritam12426@users.noreply.github.com'"


# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# For change dir()
alias hdir="cd ~/Developer/html/"
alias rdir="cd ~/Developer/rust/"
alias spdir="cd ~/Developer/system_script/"
alias cdir="cd ~/Developer/c_lang/practic/"
alias pydir="cd ~/Developer/python/practic/"
alias gdir="cd ~/Developer/git_repositories/"
alias tdir="cd /Volumes/T7/main/videos/courses/"
alias pdir="cd $present_working_project_directory"


# System scripts
alias lfind="alias | grep -i "
alias tree="tre -e"
alias hc="cat /dev/null > ~/.zsh_history"
alias nq="networkquality"
alias gfind="ls -aF --color=auto | grep -i"
alias lh="ls -aF --color=auto | egrep '^\.'"
alias findds="find . -type f -name '.DS_Store'"
alias envpath="echo $PATH | tr ':' '\n' | bat"
alias exf="exiftool -sort -P -overwrite_original_in_place"
alias removeds="echo 'removed:' && findds && find . -name '.DS_Store' -exec rm -f {} +"
alias rmdes="exiftool -P -overwrite_original_in_place -longdescription='' -description=''"
alias scrcpy_r="scrcpy -r ~/Movies/screen_cast/scrcpy_$(date +'%Y-%m-%d_%H-%M-%S').mp4"

# yt-dlp
alias yt-dlpwd="yt-dlp -o '%(title)s.%(ext)s'"
alias yt-dlpp="yt-dlp -o '~/Downloads/yt_dlp/youtube_playlist/%(playlist)s-%(uploader)s/%(playlist_index)s-%(title)s.%(ext)s'"
alias yt-dlpx="yt-dlp -o '%(title)s.%(ext)s' -f 'best/bestvideo*+bestaudio*'"
alias short="yt-dlp --no-embed-thumbnail --no-mtime -o '~/Downloads/yt_dlp/youtub_short/%(channel)s-%(title)s_%(id)s.%(ext)s' -f 'best/bestvideo*+bestaudio*'"
alias insta="yt-dlp --no-mtime -o '~/Downloads/yt_dlp/insta/%(channel)s-%(id)s_%(uploader_id)s.%(ext)s' -f 'best/bestvideo*+bestaudio*' --cookies-from-browser 'firefox'"

alias song="ffplay -vf \"crop=h=800\" -ss 6741 -t 70 -loop -1 ~/Movies/movies/brahmastra_part_1.mkv -window_title ' ' >/dev/null 2>&1"

# NNN file manager
export NNN_COLORS='5236'
export NNN_OPTS="RAUNdxe"
export NNN_OPENER="r"
export NNN_FIFO=/Users/pritam/Library/Caches
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
export NNN_PLUG='g:gitroot;c:cbcopy-mac'
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

	# The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
	# If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
	# see. To cd on quit only on ^G, remove the "export" and make sure not to
	# use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
	#      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
	export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

	# Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
	# stty start undef
	# stty stop undef
	# stty lwrap undef
	# stty lnext undef

	# The command builtin allows one to alias nnn to n, if desired, without
	# making an infinitely recursive alias
	command nnn "$@"

	[ ! -f "$NNN_TMPFILE" ] || {
		. "$NNN_TMPFILE"
		rm -f "$NNN_TMPFILE" > /dev/null
	}
}

function pathcp {
	# local file="${1:-.}"
	local file="${1:-}"
	[[ $file = /* ]] || file="$PWD/$file"
	echo "${file:a}" | tr  '\n' ' ' | pbcopy
}

# IP / macId alias and functions
alias ipinfo="curl https://raw.githubusercontent.com/jarun/nnn/master/plugins/ipinfo 2>> /dev/null | sh"
alias wanip="curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'"  # will print the loal ipv4 in termial.
alias macid="ifconfig -a | grep ether | grep -oE '([0-9][0-9]:[a-z][0-9]:[a-z][a-z]:[a-z][a-z]:[0-9][0-9]:[0-9][0-9])' | head -n 1"  # will print the return the macid of the computer
alias lanip="ifconfig -a | egrep -A 7 '^en0' | grep inet | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | head -n 1"

