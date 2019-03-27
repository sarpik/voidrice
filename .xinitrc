#!/bin/sh
# $HOME/.xinitrc
#
# also take a look at
# /etc/X11/xorg.conf.d/70-synaptics.conf
#

# set ALT + SHIFT to change layouts from US to LT & vice versa
setxkbmap -option "grp:switch,grp:alt_shift_toggle,grp_led:scroll" -layout "us,lt" &

# enables clicking the touchpad
# https://bbs.archlinux.org/viewtopic.php?pid=1740153#p1740153
# https://askubuntu.com/a/339588
#synclient TapButton1=1 &

# also, take a look at
# /etc/X11/xorg.conf.d/70-synaptics.conf

# load config from ~/.Xdefaults
xrdb "$HOME/.Xdefaults"

# enable num lock on startup
# https://wiki.archlinux.org/index.php/Activating_Numlock_on_Bootup#X.org
numlockx &

# automatic screen brightness adjustment, blue light filtering and more
# https://wiki.archlinux.org/index.php/Redshift
nohup redshift &

exec i3
