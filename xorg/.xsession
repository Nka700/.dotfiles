#!/bin/sh

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8

export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/.local/bin:$PATH"

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

exec dbus-launch --exit-with-session sh -c '
  setxkbmap -layout jp -model pc105 2>/tmp/setxkbmap.log || true
  fcitx5 -d 2>/tmp/fcitx5.log || true
  exec startxfce4
'
