# This file conten only aliases for "zsh/bash"

# For neo nvim
alias erc="nvim ~/.zshrc"
alias enc="nvim ~/.config/nvim/init.vim" 
alias eza="nvim ~/.oh-my-zsh/plugins/alias/alias.plugin.zsh"

# Fro change dir()
alias rdir="cd ~/Desktop/programming/rust/"
alias cdir="cd ~/Desktop/programming/c_lan/"
alias gdir="cd ~/Desktop/programming/git_repositories/"
alias pydir="cd ~/Desktop/programming/python/practic/"
alias spdir="cd ~/Desktop/programming/system_script/"
alias hdir="cd ~/Desktop/programming/html/"

# System scrcpy with out python
alias gfind="ls --color=auto -aF | grep"
alias rmt7="sudo umount /media/pritam/T7"
alias exiftool_f="exiftool -overwrite_original"
alias rmdes="exiftool -overwrite_original -longdescription='' -description=''"
alias scrcpy_r="scrcpy -m 1080 --max-fps=60 -r ~/Videos/screencasts/scrcpy_$(date +'%Y-%m-%d_%H-%M-%S').mp4"

# NNN file manager
export NNN_OPTS="Rde"
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
export NNN_COLOR="#00ff00"
export NNN_PLUG='o:fzopen;'
export NNN_BMS="a:/run/user/1000/gvfs/;h:~/;g:~/Desktop/programming/git_repositories/;c:~/Desktop/programming/;s:~/Desktop/programming/system_script/;t:~/.local/share/Trash/files;v:~/Videos/courses;p:/media/pritam/"
# set --export NNN_FIFO "/tmp/nnn.fifo"

