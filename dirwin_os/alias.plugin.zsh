# This file conten only aliases for "zsh/bash"

export CLICOLOR=1 
export LSCOLORS=ExFxBxDxCxegedabagacad 

# For neo nvim
alias erc="nvim ~/.zshrc"
alias evrc="sudo vim /etc/vim/vimrc" 
alias enrc="nvim ~/.config/nvim/init.vim" 
alias eza="nvim ~/.oh-my-zsh/plugins/alias/alias.plugin.zsh"

# Fro change dir()
alias tdir="cd /Volumes/T7/main"
alias hdir="cd ~/Developer/html/"
alias rdir="cd ~/Developer/rust/"
alias spdir="cd ~/Developer/system_script/"
alias cdir="cd ~/Developer/c_lang/practic/"
alias pydir="cd ~/Developer/python/practic/"
alias gdir="cd ~/Developer/git_repositories/"

# System scrcpy with out python
alias vi="nvim"
alias lh="ls -aF --color=auto | egrep '^\.'"
alias nq="networkquality"
alias tree="tre -ae"
alias gfind="ls -aF --color=auto | grep -i"
alias exiftool_f="exiftool -overwrite_original"
alias rmdes="exiftool -overwrite_original -longdescription='' -description=''"
alias yt-dlpp="yt-dlp -o '~/Downloads/yt_dlp/%(playlist)s/%(playlist_index)s-%(title)s.%(ext)s'"
alias yt-dlpwd="yt-dlp -o '%(title)s.%(ext)s'"
alias gitconfig="git config user.name 'Pritam' && git config user.email 'pritamkumar12426@gmail.com'"
alias scrcpy_r="scrcpy -m 1080 --max-fps=60 -r ~/Movies/screen_cast/scrcpy_$(date +'%Y-%m-%d_%H-%M-%S').mp4"
alias envpath='echo; tr ":" "\n" <<< "$PATH"; echo;'
alias githubconfig="git config user.name 'Pritam' && git config user.email '84720825+pritam12426@users.noreply.github.com'"

alias song="ffplay -fs -ss 6741 -t 70 -loop -1 ~/Movies/movies/brahmastra_part_1.mkv >>/dev/null 2>&1"

# NNN file manager
export NNN_OPTS="Rde"
export NNN_COLOR="#00ff00"
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
export NNN_BMS="c:~/Developer/;d:/Volumes/;h:~;y:~/Downloads/yt_dlp/"

# IP alias and functions
alias wanip="curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'"
alias lanip="ifconfig -a | egrep -A 7 '^en0' | grep inet | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | head -n 1"

