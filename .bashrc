#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

alias grep='grep --color=auto'

setxkbmap gb

function prompt_command {
	NUMCPUS=$(nproc)
	ONEMINLOAD=$(uptime | sed -e "s/.*load average: \(.*\...\), \(.*\...\), \(.*\...\)/\1/" -e "s/ //g")
	LOAD=$(echo -e "scale=0 \n $ONEMINLOAD/0.01/$NUMCPUS \nquit \n" | bc)
	if [ $LOAD -gt 99 ]
	then
		LOAD_COLOUR='0;31m'
	elif [ $LOAD -gt 49 ]
	then
		LOAD_COLOUR='0;33m'
	else
		LOAD_COLOUR='0;94m'
	fi
	HOST=$(uname -n)
	if [ $HOST != 'arthur'  ]
	then
		HOST_COLOURBG='102m'
		HOST_COLOURBG2='42m'
		HOST_COLOURFG='92m'
		HOST_COLOURFG2='32m'
	else
		HOST_COLOURBG='104m'
		HOST_COLOURBG2='44m'
		HOST_COLOURFG='94m'
		HOST_COLOURFG2='34m';
	fi
}
PROMPT_COMMAND=prompt_command
if [[ ${EUID} == 0 ]] ; then
	PS1=$'\n\[\e[$LOAD_COLOUR\e[101m\]\ue0b0\[\e[0;97m\e[101m\] \h \ue0b1 \u \[\e[91m\e[41m\]\ue0b0\[\e[1;97m\] \W \[\e[0;31m\e[100m\]\ue0b0\[\e[0;97m\e[100m\] \$ \[\e[90m\e[49m\]\ue0b0\[\e[0m\] '
else
	PS1=$'\n\[\e[$LOAD_COLOUR\e[$HOST_COLOURBG\]\ue0b0\[\e[0;97m\e[$HOST_COLOURBG\] \h \ue0b1 \u \[\e[$HOST_COLOURFG\e[$HOST_COLOURBG2\]\ue0b0\[\e[1;97m\] \W \[\e[0;$HOST_COLOURFG2\e[100m\]\ue0b0\[\e[0;97m\e[100m\] \$ \[\e[90m\e[49m\]\ue0b0\[\e[0m\] '
fi

please(){
	sudo -- "${SHELL:-bash}" -c "$(fc -ln -1)"
}

export EDITOR=vim
export SUDO_EDITOR=vim

alias mpv-yt='mpv --ytdl-format "bestvideo[height=1080]+bestaudio/best+protocol!=http_dash_segments" --save-position-on-quit' --cache-default=1024000

alias cd..='cd ..'
alias ..='cd ..'

alias duh='du -h --max-depth=1'

alias bedtime='~/.i3/i3lock-custom && systemctl hibernate'

if [ -e ~/.bashrc_private ]; then
  source ~/.bashrc_private
fi
