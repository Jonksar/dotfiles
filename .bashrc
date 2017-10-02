# prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# Setting history length
export HISTCONTROL="ignoredups:erasedups"
export HISTTIMEFORMAT="[%F %T] "
export HISTSIZE=999999
export HISTFILESIZE=$HISTSIZE;
# Make some commands not show up in history
export HISTIGNORE="ls:ll:cd:cd -:pwd:exit:date:history"

# Append to the history file, don't overwrite it.
shopt -s histappend
# Allow us to re-edit a failed history substitution.
shopt -s histreedit
# History expansions will be verified before execution.
shopt -s histverify

# Case-insensitive globbing (used in pathname expansion).
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`.
shopt -s cdspell

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# After each command, append to the history file and reread it.
# Source: https://unix.stackexchange.com/a/1292
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Make vim the default editor
export EDITOR="vim"

# Colorize the ls command
export LS_COLORS="di=36;40:ln=35;40:so=31;:pi=0;:ex=1;;40:bd=0;:cd=37;:su=37;:sg=0;:tw=0;:ow=0;:"

# Force colored output and good defaults
alias du='du -csh'
alias df='df -h'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff="colordiff -ru"
alias dmesg="dmesg --color"
alias tree='tree -Csh'
alias ccat='pygmentize -g'

alias top="htop"
alias gr='grep -RIi --no-messages'
alias vi='vim'
alias v="vim"
alias g="git"
alias h="history"
alias q='exit'

# Use GRC for additionnal colorization
GRC=$(which grc)
if [ -n GRC ]; then
    alias colourify='$GRC -es --colour=auto'
    alias as='colourify as'
    #cvs
    alias configure='colourify ./configure'
    alias diff='colourify diff'
    alias dig='colourify dig'
    alias g++='colourify g++'
    alias gas='colourify gas'
    alias gcc='colourify gcc'
    alias head='colourify head'
    alias ifconfig='colourify ifconfig'
    #irclog
    alias ld='colourify ld'
    #ldap
    #log
    alias ls='colourify ls'
    alias make='colourify make'
    alias mount='colourify mount'
    #mtr
    alias netstat='colourify netstat'
    alias ping='colourify ping'
    #proftpd
    alias ps='colourify ps'
    alias tail='colourify tail'
    alias traceroute='colourify traceroute'
    #wdiff
fi

export lsflags="--color=auto"

# Detect which `ls` flavor is in use
alias ll='ls -lah ${lsflags}'
alias ls='ls -hFp ${lsflags}'

export LESS="-eRX"
export LESSOPEN='| pygmentize -g %s'

# Don't let Python produce .pyc or .pyo. Left-overs can produce strange side-effects.
export PYTHONDONTWRITEBYTECODE=true

# Python shell auto-completion and history
export PYTHONSTARTUP="$HOME/.python_startup.py"

eval "$(pip completion --bash)"

# Extract most know archives with one command
# might not work atm 100%
extract () {
    if [ -f "$1" ]; then
        case $1 in
            *.tar.bz2)  tar xjf "$1"    ;;
            *.tar.gz)   tar xzf "$1"    ;;
            *.bz2)      bunzip2 "$1"    ;;
            *.rar)      unrar e "$1"    ;;
            *.gz)       gunzip "$1"     ;;
            *.tar)      tar xf "$1"     ;;
            *.tbz2)     tar xjf "$1"    ;;
            *.tgz)      tar xzf "$1"    ;;
            *.xz)       tar xJf "$1"    ;;
            *.zip)      unzip "$1"      ;;
            *.Z)        uncompress "$1" ;;
            *.7z)       7z x "$1"       ;;
            *.xar)      xar -xvf "$1"   ;;
            *.pkg)      xar -xvf "$1"   ;;
            *)          echo "'$1' cannot be extracted via extract()";;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# GO LANG PATH
GOPATH=~/.go/

# Handy line count tool (FAST)
# https://github.com/loov/qloc/releases
wl() {
    /bin/qloc_linux_amd64 "$@"
}

# Handy filecount tool
# alias fc="tree | tail -2"
alias cb="xclip -sel clip"

# eliminate ls typing errors
alias l="ls"
alias sl="ls"

# get oldest and newest filenames
alias newest="ls -t | head -1"
alias oldest="ls -t | tail -1"

# shorthand for git
alias ,pp="git pull && git push"
alias ,gs="git status"

# rm asks if I am sure
alias rm="rm -I"
alias cse="2>&1"

lst() {
    ls -t "$@"
}

nth() {
    head -"$1" | tail -1
}


rth() {
    tail -"$1" | head -1
}

where() {
    whereis "$@" | awk ' {print $2} '
}

alias latest_changes="find -type f -exec stat --format '%Y :%y %n' {} \; | sort -nr | cut -d: -f2- | head"

# Setting history length
export HISTCONTROL="ignoredups:erasedups"
export HISTTIMEFORMAT="[%F %T] "
export HISTSIZE=999999
export HISTFILESIZE=$HISTSIZE;
# Make some commands not show up in history
export HISTIGNORE="ls:ll:cd:cd -:pwd:exit:date:history"

eval $(thefuck --alias)

