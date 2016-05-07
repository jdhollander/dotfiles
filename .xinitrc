setxkbmap gb
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xset s off
pulseaudio --start
exec i3
