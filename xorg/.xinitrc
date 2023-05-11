#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# X Key Bindings 
xbindkeys &
setxkbmap us &
picom --config ~/.config/picom/picom.conf &
xinput set-prop 15 295 -0.7 &

export QT_SELECT=5
export QT_QPA_PLATFORMTHEME=qt5ct
export EDITOR=nvim
export ALARM_SOUND=$HOME/Documents/alarm.mp3
export CMAKE_GENERATOR=Ninja
exec i3
