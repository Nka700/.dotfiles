#!/bin/sh

[ -f ~/.xprofile ] && source ~/.xprofile

#Exec DWM
#exec dwm
exec dbus-run-session -- sh -c 'exec dwm & fcitx5 -d'
