#!/bin/sh
# $HOME/.xinitrc
#
# also take a look at
# /etc/X11/xorg.conf.d/70-synaptics.conf
#

# set ALT + SHIFT to change layouts from US to LT & vice versa
#setxkbmap -option "grp:switch,grp:alt_shift_toggle,grp_led:scroll" -layout "us,lt" &
# NOTE - moved to /etc/X11/xorg.conf.d/00-keyboard.conf
# READ MORE at https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration#Using_X_configuration_files

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
#[ numlockx --help >/dev/null 2>&1 ] && numlockx &
numlockx &

# automatic screen brightness adjustment, blue light filtering and more
# https://wiki.archlinux.org/index.php/Redshift
#[ redshift -h >/dev/null 2>&1 ] && nohup redshift &
nohup redshift &

exec i3
