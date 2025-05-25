#!/bin/sh

# sourced at boot by ~/.xinitrc and most display managers

export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/.local/bin:$PATH"
#
#picom -b -c &
nm-applet &
volumeicon &
nitrogen --restore &
xfce4-power-manager &
xset dpms 600 900 1200
xset r rate 350 60
#
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5
export GLFW_IM_MODULE=ibus
#fcitx5
#
## start clipboard manager
copyq &

