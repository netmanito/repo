## This is a global .bashrc file with options for gnu/linux and Mac OS X 
## lets start

## history control
HISTFILESIZE=50000
HISTSIZE=1000
HISTCONTROL=ignoredups
# PROMPT_COMMAND='history -a'
# shopt -s histappend

## Options
HOME="/Users/youruser"
ENV=$HOME/.bashrc
export ENV
SHELL=/bin/bash

GREP_COLOR="0;32"
#PATH=$PATH:/bin:/usr/bin:/sbin:/usr/local/bin:"~/bin"
PATH=/opt/local/bin:$PATH:$HOME/bin:/usr/local/bin:/sw/bin:/sw/sbin:/bin:/sbin:/usr/bin:/usr/sbin

# this is from fink for osX
# test -r /sw/bin/init.sh && . /sw/bin/init.sh

# If running interactively, then:
if [ "$PS1" ]; then

## PS options

PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[m\] \[\e[1;32m\]\$ \[\e[m\]\[\e[1;37m\] '

PS1="\n<\[\033[0;34m\]\u\[\033[0m\]@\[\033[0;34m\]\h\[\033[0m\]>#\[\033[0;32m\](\$(/Users/jaci/bin/TBytes.sh) Mb\[\033[0;32m\])\033[0m\]\w$: "; fi

# don't put duplicate lines in the history. See bash(1) for more options
# export HISTCONTROL=ignoredups
# enable color support of ls and also add handy aliases
eval `dircolors -b`
alias ls='ls --color=auto -l'
#alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ssh='ssh -vC'
alias xroot='xcommand Eterm --trans -0 --buttonbar 0 --shade 80% -t Escreen -F smoothansi'
alias term='Eterm -T Dorotea --trans -O --buttonbar 0'
alias xterm='xterm -bg black -fg white'
alias down='sudo halt'
alias play='mplayer -cache 8192 -vfm ffmpeg -lavdopts lowres=1:fast:skiploopfilter=all -zoom -ao sdl'
alias noplay='mplayer -cache 8192 -vfm ffmpeg -lavdopts lowres=1:fast:skiploopfilter=all -zoom -nosound'
alias mplayer2='mplayer2 -cache 8192 -ao sdl -zoom'
alias lock='xlock -mode matrix'
alias nautilus='nautilus --no-desktop'
alias z='startx'
alias casa='ssh -vC 192.168.1.1'
alias Eterm='Eterm --trans 0 --buttonbar 0 --shade 50%'
alias hist='history | grep $1'
alias cal='cal -m'

    alias ssh='ssh -vC'
    alias pid=' ps aux -ww|cut -d : -f 2 |grep'
    alias l='ls -GC'
    alias la='ls -lasGC'
    alias vdir='ls -lhsGC|more'
    alias dir='ls -lGC'
    alias ll='ls -G |more'
    alias die='killall ssh'
## Funcionts
function rae ()
{
    links -dump -fake-user-agent "Mozilla/5.001 (windows; U; NT4.0; en-US; rv:1.0) Gecko/25250101" "http://buscon.rae.es/draeI/SrvltGUIBusUsual?LEMA="$1|tail -n+7|head -n-2|sed -e 'N;s/\n//'
}
function rhost () {
    for i in `host $1|grep "has address"|awk '{print $4}'`
        do
            host $i|grep pointer|awk '{print "'$i'\t"$5}'
        done
}
function dusort () {
    du -s $1/* | sort -n | cut -f 2- | while read a; do du -sh "$a" ; done
}
# If this is an xterm set the title to user@host:dir
case $TERM in
xterm*)
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
;;
*)
;;
esac
