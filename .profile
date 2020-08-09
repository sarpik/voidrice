#!/usr/bin/env sh
# ~/.profile
# Profile file. Runs on login. Environmental variables are set here.

# Get default LARBS WM from ~/.local/share/larbs/wm
export LARBSWM="$(cat ~/.local/share/larbs/wm 2>/dev/null)" &&
	[ "$LARBSWM" = "dwm" ] || export LARBSWM="i3"

# Adds `~/.local/bin/` and all subdirectories to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

export PATH="$PATH:$HOME/.cargo/bin:$HOME/go/bin"
export PATH="$PATH:$HOME/.gem/ruby/2.6.0/bin"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:/home/kipras/.gem/ruby/2.7.0/bin" # WE'VE REVERSELY FALLEN FOR THE MEME BOYZ
export PATH="$PATH:/home/kipras/builds/DataGrip-2019.3.2/bin" # WE'VE REVERSELY FALLEN FOR THE MEME BOYZ
export PATH="$PATH:/opt/resolve/bin"

# Default programs:
export EDITOR="nvim"
export REACT_EDITOR="vscodium"
export SUDO_EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"
export FILE="lf"
export STATUSBAR="${LARBSWM}blocks"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export WAKATIME_HOME="$HOME/.config/wakatime"
export PLATFORMIO_CORE_DIR="$HOME/.config/platformio"
export BIB="$HOME/Documents/LaTeX/uni.bib"
export REFER="$HOME/Documents/referbib"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch-config"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ALSA_CONFIG_PATH="$XDG_CONFIG_HOME/alsa/asoundrc"
#export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"

export DOTNET_CLI_TELEMETRY_OPTOUT=1 # https://wiki.archlinux.org/index.php/.NET_Core#Telemetry
export DOTNET_ROOT="/opt/dotnet" # https://wiki.archlinux.org/index.php/.NET_Core#Troubleshooting
export MSBuildSDKsPath="/opt/dotnet/sdk/3.0.100/Sdks";
#export MSBuildSDKsPath="/opt/dotnet/sdk/2.2.108/Sdks";
##export N_PREFIX="$HOME/.local/share/n"

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.

# Other program settings:
export DICS="/usr/share/stardict/dic/"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export LESS=-R
#export LESSHISTFILE="$HOME/.cache/less/history"
export LESSHISTFILE="-"
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.

# This is the list for lf icons:
export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📚:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.avi=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
"

[ ! -f ${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc ] && shortcuts >/dev/null 2>&1 &

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! ps -e | grep -qw Xorg && exec startx

# Switch escape and caps if tty and no passwd required:
sudo -n loadkeys ~/.local/share/larbs/ttymaps.kmap 2>/dev/null

# Various bs

# gpg stuff
# https://bbs.archlinux.org/viewtopic.php?pid=1490821#p1490821
export GPG_TTY=$(tty)
export GPG_AGENT_INFO=""
#eval $(keychain --eval -Q --quiet id_rsa)

# see https://wiki.archlinux.org/index.php/GnuPG#Configure_pinentry_to_use_the_correct_TTY
# questionable if I need this
gpg-connect-agent updatestartuptty /bye >/dev/null

# react-native
# https://facebook.github.io/react-native/docs/getting-started#3-configure-the-android_home-environment-variable
export ANDROID_HOME="$HOME"/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# xampp
export PATH="$PATH:/opt/lampp"
export PATH="$PATH:$HOME/.local/bin"

# sourcemod / sourcepawn
export PATH="$PATH:$HOME/.local/share/sourcemod/addons/sourcemod/scripting"

# nosqlclient (for mongo)
export MONGO_URL="/usr/bin/mongo"

# deno
export DENO_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/deno"
export DENO_INSTALL_ROOT="$DENO_DIR/bin"

# snap
export PATH="$PATH:/var/lib/snapd/snap/bin"

# https://stackoverflow.com/a/18434831
case "$OSTYPE" in
  solaris*) echo "SOLARIS" ;;
  darwin*)
	  	echo "OSX"
		export PATH="/usr/local/opt/python/libexec/bin:$PATH"
	  
		# see https://stackoverflow.com/a/57973942/9285308
		# make GNU commands available
		export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
		export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"
		
		export PATH="$PATH:/Applications/Firefox Developer Edition.app/Contents/MacOS/"

	  ;; 
  linux*)   #echo "LINUX" ;;
  		;;
  bsd*)     #echo "BSD" ;;
  		;;
  msys*)    #echo "WINDOWS" ;;
  		;;
  *)        #echo "unknown: $OSTYPE" ;;
  		;;
esac
