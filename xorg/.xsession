#!/bin/sh

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

[ -r "$HOME/.xprofile" ] && . "$HOME/.xprofile"

exec dbus-launch --exit-with-session sh -c '
  setxkbmap -rules evdev -model pc105 -layout jp -variant "" -option "" 2>/tmp/setxkbmap.log || true
  fcitx5 -d 2>/tmp/fcitx5.log || true
  exec startxfce4
'
