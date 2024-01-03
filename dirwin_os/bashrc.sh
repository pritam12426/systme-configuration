export PATH="$HOME/Developer/system_script:$PATH"
source "$HOME/.oh-my-zsh/plugins/alias/alias.plugin.zsh"

# aliases ---------------------------------------------------
alias h="history"
alias erc="nvim ~/.bashrc"
alias hc="cat /dev/null > ~/.bash_history"
# -----------------------------------------------------------

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# PS1 variable
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

alias ls='ls --color=auto'
alias dir='dir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -lah'

. "$HOME/.cargo/env"
