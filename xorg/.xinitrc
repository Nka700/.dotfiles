#!/bin/sh

xrdb=xrdb
xinitdir=/etc/X11/xinit
xclock=xclock
xterm=xterm
twm=twm
xmodmap=xmodmap

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=$xinitdir/.Xresources
sysmodmap=$xinitdir/.Xmodmap

# merge in defaults and keymaps

export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/.local/bin:$PATH"

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

#DWM Status
#dwmstatus 2>&1 >/dev/null &
#$HOME/dwm-bar/dwm_bar.sh &
exec slstatus &
#NetworkManager
nm-applet &
#xfce4-power-manager &
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#gnome-keyring-daemon --start --components=pkcs11 &

#Keyboard Layout
setxkbmap us &

#Display Resolution
#xrandr --output Virtual-1 --mode 1920x1080
xrandr -s 1920x1080 &

#Wallpaper
nitrogen --restore &
#nitrogen --force-setter=xinerama --restore &

#fcitx5
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5
export GLFW_IM_MODULE=ibus
fcitx5 &

# disable TouchPad for Thinkpad
#xinput disable 'SynPS/2 Synaptics TouchPad'

## start clipboard manager
copyq &

# start conkyrc
CONKYCONFIGS=`find ${HOME}/.config -name "*conkyrc*"`
echo ${CONKYCONFIGS}
for CONFIG in ${CONKYCONFIGS}
do
    conky -b -c ${CONFIG}
    sleep 3
done

# start blueman
blueman-applet &

#Exec DWM
exec dwm
