#!/bin/sh

[ -f ~/.xprofile ] && . ~/.xprofile

#Exec DWM
exec dwm
#exec dbus-run-session -- dwm
