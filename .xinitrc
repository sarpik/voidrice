#!/bin/sh

### --- ###

# $HOME/.xinitrc
#
# also take a look at
# /etc/X11/xorg.conf.d/70-synaptics.conf
#

# set ALT + SHIFT to change layouts from US to LT & vice versa
setxkbmap -option "grp:switch,grp:alt_shift_toggle,grp_led:scroll" -layout "us,lt" &
# ~~ NOTE - moved to /etc/X11/xorg.conf.d/00-keyboard.conf ~~
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

# keyboard remaps (called by i3)
#. ~/.scripts/tools/remaps

# automatic screen brightness adjustment, blue light filtering and more
# https://wiki.archlinux.org/index.php/Redshift
#[ redshift -h >/dev/null 2>&1 ] && nohup redshift &
nohup redshift &

# https://wiki.archlinux.org/index.php/GNOME/Keyring#PAM_method
# dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

#
# The fix: https://unix.stackexchange.com/a/295652
#
# Also related:
# https://bbs.archlinux.org/viewtopic.php?id=231006
#
mkdir -p "$HOME"/.local/share/keyrings
##source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# allow `screenlockuser` to do stuff with my screen (TODO -see project "screenlock")
xhost +SI:localuser:screenlockuser

### --- ###

# xinitrc runs automatically when you run startx.

# There are some small but important commands that need to be run when we start
# the graphical environment. I keep those commands in ~/config/xprofile because
# that file is run automatically if someone uses a display manager (login
# screen) and so they are needed there. To prevent doubling up commands, I
# source them here with the line below.

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/xprofile" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/xprofile"

# Your default LARBS WM is determined in your `~/.profile` on login.  Here we
# run the proper command to run when the graphical environment starts.

##exec dwm

# To use i3, comment out the line above with dwm and uncomment these two:
# export STATUSBAR="i3blocks"
exec i3
