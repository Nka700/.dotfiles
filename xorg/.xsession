#!/bin/sh

export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/.local/bin:$PATH"

# NetworkManager applet
nm-applet &

# Keyboard Layout
setxkbmap jp &

# fcitx5 (Japanese input)
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5
export GLFW_IM_MODULE=ibus
fcitx5 &

# Start XFCE4 session
exec startxfce4
