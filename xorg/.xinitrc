#!/bin/sh

[ -f ~/.xprofile ] && source ~/.xprofile

#Exec DWM
#exec dwm
exec dbus-run-session -- sh -c 'fcitx5 -d & exec dwm'
