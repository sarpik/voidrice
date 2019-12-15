#!/bin/bash
#!/usr/bin/env bash
stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd # Allows you to cd into directory merely by typing the directory name.

set -o physical # Cd into symlink as if you cd'd into the actual directory
# see more @ https://unix.stackexchange.com/a/55715/332452

#export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
export PS1='\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 15)\]\[$(__git_ps1 " (%s)")\]\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]'

# begin history cfg
# originally from https://stackoverflow.com/a/19533853/9285308

# Infinite history
export HISTSIZE=
export HISTFILESIZE=
# adds [YYYY-MM-DD HH:MM:SS] prefix
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE="$HOME/.cache/bash/history"
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# Don't add to history if prefixed with a space
export HISTCONTROL="ignorespace"

# end history cfg

#
# store gpg & ssh keys across logins
#
# https://wiki.archlinux.org/index.php/SSH_keys#SSH_agents
# https://wiki.archlinux.org/index.php/GnuPG#Reload_the_agent
# https://wiki.archlinux.org/index.php/GnuPG#Cache_passwords
# https://wiki.archlinux.org/index.php/GnuPG#Configuration_2
# "gpg-preset-passphrase: caching passphrase failed: Not supported"
# https://wiki.gnupg.org/TroubleShooting#Passphrase_on_the_command_line
#
# https://gnupg.org/documentation/manuals/gnupg/gpg_002dpreset_002dpassphrase.html
# https://gnupg.org/documentation/manuals/gnupg/Invoking-gpg_002dpreset_002dpassphrase.html#Invoking-gpg_002dpreset_002dpassphrase
# https://www.funtoo.org/Keychain
# keychain fails to store gpg keys arch linux
#
#eval $(keychain --eval --quiet --confhost --noask id_ed25519 id_rsa ~/.keys/my_custom_key --agents "gpg,ssh")
eval $(keychain --eval --quiet --confhost --noask id_rsa id_rsa --agents "gpg,ssh")

# bash-completion is automatically loaded (installed via AUR)

if [ -f "$HOME/.config/git/git-completion.bash" ]; then
	source "$HOME/.config/git/git-completion.bash" &&
	__git_complete g __git_main &&
	__git_complete config __git_main &&
	__git_complete co __git_main
	# enables git completion for git's alias 'g' as defined in ~/.config/aliasrc
fi

# https://github.com/github/hub/
if [ -f "$HOME/.config/git/hub.bash_completion" ]; then
	source "$HOME/.config/git/hub.bash_completion"
fi

[ -f "$HOME/.config/git/git-prompt.sh" ] && source "$HOME/.config/git/git-prompt.sh"

[ -f "$HOME/.config/kubernetes/kubectl-completion.bash" ] && source "$HOME/.config/kubernetes/kubectl-completion.bash"

# More info @ ~/.config/git-prompt.sh & ~/.config/git-completion.bash
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
#export GIT_PS1_SHOWUPSTREAM="auto verbose name"
export GIT_PS1_SHOWUPSTREAM="auto verbose"
export GIT_PS1_DESCRIBE_STYLE="default"

# https://github.com/rupa/z
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export GPG_TTY="$(tty)"
export PASSWORD_STORE_DIR="$HOME/.password-store"

# load stuff
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

