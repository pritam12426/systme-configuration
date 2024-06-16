# This file conten only aliases for "zsh/bash"

# For neo nvim
alias erc="nvim ~/.zshrc"
alias evrc="sudo vim /etc/vim/vimrc" 
alias enrc="nvim ~/.config/nvim/init.vim" 
alias eza="nvim ~/.oh-my-zsh/plugins/alias/alias.plugin.zsh"

# Fro change dir()
alias ddir="cd ~/Downloads/"
alias tdir="cd /media/pritam/T7/main"
alias hdir="cd ~/Desktop/programming/html/"
alias rdir="cd ~/Desktop/programming/rust/"
alias spdir="cd ~/Desktop/programming/system_script/"
alias cdir="cd ~/Desktop/programming/c_lang/practic/"
alias pydir="cd ~/Desktop/programming/python/practic/"
alias gdir="cd ~/Desktop/programming/git_repositories/"

# System scrcpy with out python
alias vi="nvim "
alias tree="tre -ae "
alias gfind="ls --color=auto -aF | grep "
alias rmt7="sudo umount /media/pritam/T7/"
alias exiftool_f="exiftool -overwrite_original "
alias rmdes="exiftool -overwrite_original -longdescription='' -description='' "
alias yt-dlpp="-o '~/Downloads/yt_dlp/%(playlist)s/%(playlist_index)s-%(title)s.%(ext)s' "
alias gitconfig="git config user.name 'Pritam' && git config user.email 'pritamkumar12426@gmail.com'"
alias scrcpy_r="scrcpy -m 1080 --max-fps=60 -r ~/Videos/screencasts/scrcpy_$(date +'%Y-%m-%d_%H-%M-%S').mp4"
alias githubconfig="git config user.name 'Pritam' && git config user.email '84720825+pritam12426@users.noreply.github.com'"

# NNN file manager
export NNN_OPTS="Rde"
export NNN_COLOR="#00ff00"
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
export NNN_BMS="a:/run/user/1000/gvfs/;h:~/;c:~/Desktop/programming/;t:~/.local/share/Trash/files;p:/media/pritam/"

alias song="ffplay -fs -ss 6741 ~/Videos/movies/brahmastra_part_1.mkv >>/dev/null 2>&1"
