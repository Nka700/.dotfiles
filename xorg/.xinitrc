#!/bin/sh

xrdb=xrdb
xinitdir=/etc/X11/xinit
xmodmap=xmodmap

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=$xinitdir/.Xresources
sysmodmap=$xinitdir/.Xmodmap

export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/.local/bin:$PATH"

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    if [ -x /usr/bin/cpp ] ; then
        $xrdb -merge $sysresources
    else
        $xrdb -nocpp -merge $sysresources
    fi
fi

if [ -f $sysmodmap ]; then
    $xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        $xrdb -merge "$userresources"
    else
        $xrdb -nocpp -merge "$userresources"
    fi
fi

if [ -f "$usermodmap" ]; then
    $xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d $xinitdir/xinitrc.d ] ; then
 for f in "$xinitdir/xinitrc.d"/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

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
