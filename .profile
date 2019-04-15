#!/bin/sh
# Profile file. Runs on login.

# Adds `~/.scripts` and all subdirectories to $PATH
export PATH="$PATH:$(du "$HOME/.scripts/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export PATH="$PATH:$HOME/.cargo/bin"
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="google-chrome-stable"
export READER="zathura"
export FILE="ranger"
export BIB="$HOME/Documents/LaTeX/uni.bib"
export REFER="$HOME/Documents/referbib"
export SUDO_ASKPASS="$HOME/.scripts/tools/dmenupass"
export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"

export GPG_TTY=$(tty)

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

[ ! -f ~/.config/shortcutrc ] && shortcuts >/dev/null 2>&1

echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

## enable numlock on startup
## https://wiki.archlinux.org/index.php/Activating_Numlock_on_Bootup#Bash_alternative
#setleds -D +num

# Start graphical server if i3 not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx

# Switch escape and caps if tty:
sudo -n loadkeys ~/.scripts/ttymaps.kmap 2>/dev/null

export GPG_TTY=$(tty)

# git checkout -- <file/path> limitation / protection
git() {
	if [[ "$1" =~ [checkout]+ ]] && [ "$2" = "--" ]; then
		printf "WARNING\nRegex matched this as a 'git checkout -- <foo>'\nThis will OVERRIDE the file(s) PERMANENTLY!\nAre you SURE you want to continue?\n==> [y/N]: "
		read choice
		if [ "$choice" = "y" ] || [ "$choice" = "Y" ] || [ "$choice" = "yes" ] || [ "$choice" = "Yes" ]; then
			printf "I sure hope you know what you are doing."
			command git "$@"
		else
			printf "==> Aborting\n" && return 1
		fi
	else
		command git "$@"
	fi
}

