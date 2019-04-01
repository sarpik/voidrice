#!/bin/bash
stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd # Allows you to cd into directory merely by typing the directory name.

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
export HISTFILE="$HOME/.bash_eternal_history"
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# Don't add to history if prefixed with a space
export HISTCONTROL="ignorespace"

# end history cfg

# load stuff
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

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

# More info @ ~/.config/git-prompt.sh & ~/.config/git-completion.bash
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
#export GIT_PS1_SHOWUPSTREAM="auto verbose name"
export GIT_PS1_SHOWUPSTREAM="auto verbose"
export GIT_PS1_DESCRIBE_STYLE="default"

# node version manager https://github.com/creationix/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
