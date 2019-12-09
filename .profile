#!/usr/bin/env sh
# Profile file. Runs on login.

# Adds `~/.local/bin/` and all subdirectories to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export PATH="$PATH:$HOME/.cargo/bin:$HOME/go/bin"
export PATH="$PATH:$HOME/.gem/ruby/2.6.0/bin"
export PATH="$PATH:$HOME/.dotnet/tools"

export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export TERMINAL="st"
export BROWSER="google-chrome-stable"
export READER="zathura"
export FILE="vifm"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export WAKATIME_HOME="$HOME/.config/wakatime"
export PLATFORMIO_CORE_DIR="$HOME/.config/platformio"
export BIB="$HOME/Documents/LaTeX/uni.bib"
export REFER="$HOME/Documents/referbib"
export SUDO_ASKPASS="$HOME/.local/bin/tools/dmenupass"
export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export DOTNET_CLI_TELEMETRY_OPTOUT=1 # https://wiki.archlinux.org/index.php/.NET_Core#Telemetry
export DOTNET_ROOT="/opt/dotnet" # https://wiki.archlinux.org/index.php/.NET_Core#Troubleshooting
export MSBuildSDKsPath="/opt/dotnet/sdk/3.0.100/Sdks";
#export MSBuildSDKsPath="/opt/dotnet/sdk/2.2.108/Sdks";

# less/man colors
export LESS=-R
export LESSHISTFILE="$HOME/.cache/less/history"
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

mpd >/dev/null 2>&1 &

[ ! -f ~/.config/shortcutrc ] && shortcuts >/dev/null 2>&1

echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

## enable numlock on startup
## https://wiki.archlinux.org/index.php/Activating_Numlock_on_Bootup#Bash_alternative
#setleds -D +num

# Start graphical server if i3 not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && startx

# Switch escape and caps if tty:
sudo -n loadkeys ~/.local/bin/ttymaps.kmap 2>/dev/null

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

# nosqlclient (for mongo)
export MONGO_URL="/usr/bin/mongo"

