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

# this is somewhat of a 'pre-checkout' hook
# I wish that git implemented it by default
# this one protects from `git checkout -- <foo>` and/or `git checkout -- .`
#
# single quote (') escaping in sed credit: https://stackoverflow.com/a/18274451
#

# check if git exists
$(git --help >/dev/null 2>&1) && gitExists="true" || gitExists="false"
printf "\ngitExists $gitExists\n"

# if it doesn't exist, we should skip our next steps.

# get git's command
gitCmd="$(command -v git)"
printf "$gitCmd" | grep -i "alias git=" && gitIsAliased=true || gitIsAliased=false

if [ "$gitIsAliased" = "true" ]; then
	#printf "$gitCmd" | sed 's|alias git='\(.*\)'|\1|g'; '
	trueGit="$(printf "$gitCmd" | sed 's|alias git='\''\(.*\)'\''|\1|g;')"

elif [ "$gitIsAliased" = "false" ]; then
	# might be /usr/bin/git etc. or not available
	trueGit="git"
fi

printf "\ntrueGit $trueGit\n"

### TODO figure out a way to declare a function from a variable

### ---


# this is currently a temporary work-around, only support git & hub.
[ "$(command -v git)" = "alias git='hub'" ] && gitWrapper="hub" || gitWrapper="git"

if [ "$gitWrapper" = "git" ]; then
git() {
	if [[ "$1" =~ [checkout]+ ]] && [ "$2" = "--" ]; then
		printf "WARNING\n==> Regex matched this as a 'git checkout -- "

		if [ "$3" = "." ]; then
			printf ".'\n%4sThis will OVERRIDE **ALL** changes PERMANENTLY!!!"
		else
			printf "<foo>'\n%4sThis will OVERRIDE the file(s) PERMANENTLY!"
		fi

		printf "\n\n==> Are you SURE you want to continue? [y/N]: "
		read choice
		if [ "$choice" = "y" ] || [ "$choice" = "Y" ] || [ "$choice" = "yes" ] || [ "$choice" = "Yes" ]; then
			printf "\n==> I sure hope you know what you are doing...\n"
			git stash -u && \
			printf "\n==> Created a backup stash & probably saved yo butt.\n" && \
			git stash apply >/dev/null 2>&1 && \
			command git "$@"
		else
			printf "==> Aborting\n" && return 1
		fi
	else
		command git "$@"
	fi
}

elif [ "$gitWrapper" = "hub" ]; then

hub() {
	if [[ "$1" =~ [checkout]+ ]] && [ "$2" = "--" ]; then
		printf "WARNING\n==> Regex matched this as a 'git checkout -- "

		if [ "$3" = "." ]; then
			printf ".'\n%4sThis will OVERRIDE **ALL** changes PERMANENTLY!!!"
		else
			printf "<foo>'\n%4sThis will OVERRIDE the file(s) PERMANENTLY!"
		fi

		printf "\n\n==> Are you SURE you want to continue? [y/N]: "
		read choice
		if [ "$choice" = "y" ] || [ "$choice" = "Y" ] || [ "$choice" = "yes" ] || [ "$choice" = "Yes" ]; then
			printf "\n==> I sure hope you know what you are doing...\n"
			hub stash -u && \
			printf "\n==> Created a backup stash & probably saved yo butt.\n" && \
			hub stash apply >/dev/null 2>&1 && \
			command hub "$@"
		else
			printf "==> Aborting\n" && return 1
		fi
	else
		command hub "$@"
	fi
}
fi
