
# measure boot time (see also the last line)
bootTimeStart=$(date +%s%N)

# bash bash compatibility mode - see https://github.com/eddiezane/lunchy/issues/57#issuecomment-448588918
#autoload -U +X bashcompinit && bashcompinit
#
zstyle ':completion:*' matcher-list      'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # prefers not case sensitive
# zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # prefers case sensitive
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate rehash true
zstyle ':completion:*' menu select completer _expand _complete _ignored _correct _approximate rehash true
#
#bindkey -M menuselect '^?' undo
#bindkey -M 'menuselect' '^M' .accept-line
#
#
##zstyle :compinstall filename '/home/kipras/.zshrc'
zstyle :compinstall filename '$ZDOTDIT/.zshrc'
#
setopt autolist

autoload -Uz compinit
zmodload -i zsh/complist # https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52#gistcomment-3079386

compinit
_comp_options+=(globdots)		# Include hidden files.

zstyle ':completion:*' menu select

autoload -Uz promptinit
promptinit

# select the redhat prompt
prompt redhat

# hub.zsh_completion
# https://github.com/github/hub/tree/master/etc
fpath=($HOME/.config/zsh/completions $fpath)
##autoload -U compinit && compinit

# source 'git-extras' completions
# (https://github.com/tj/git-extras)
[ -f "$HOME/.config/zsh/completions/git-extras-completion.zsh" ] && source "$HOME/.config/zsh/completions/git-extras-completion.zsh"

stty stop undef		# Disable ctrl-s to freeze terminal.

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"
#[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc"

# ghcup-env (haskell poggers)
[ -f "/home/kipras/.ghcup/env" ] && source "/home/kipras/.ghcup/env"

###
# history #
# see https://unix.stackexchange.com/a/273863

HISTDIR="$HOME/.cache/zsh"
HISTFILE="$HISTDIR/history"
mkdir -p "$HISTDIR"
HISTSIZE=10000000000
SAVEHIST=10000000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt append_history            # Don't _overwrite_ history
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
#setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
#setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
#setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
#setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
#setopt HIST_BEEP                 # Beep when accessing nonexistent history.
setopt share_history             # share history between shells
setopt hist_no_store             # don't save 'history' cmd in history


# Directory changing
# adopted from https://github.com/moprak/zshrc
setopt autocd           # Automatically change directory
setopt autopushd        # Use "pushd" instead of "cd", enabling use of "popd"
setopt pushdsilent      # Make "popd" be less verbose (like cd)
##setopt pushdignoredups  # Don't record the same directory as multiple entries
setopt pushdtohome
setopt cdable_vars
DIRSTACKSIZE=10         # Limit the number of directories to keep in history

# Completion, expansion and globbing
setopt automenu
setopt autolist
#setopt complete_in_word
setopt always_to_end
setopt menucomplete
setopt listpacked
setopt globdots
setopt extendedglob
setopt markdirs
setopt nomatch
setopt numeric_glob_sort
setopt rc_quotes
##setopt rec_exact
unsetopt autoparamslash

###

# Do not insert a space after a completion / stop eating spaces where it shouldn't.
# See https://superuser.com/a/613817/1012390
ZLE_REMOVE_SUFFIX_CHARS=""

setopt appendhistory autocd extendedglob nomatch notify
### do NOT set COMPLETE_ALIASES! See https://stackoverflow.com/a/20643204
#setopt complete_aliases
unsetopt beep



### BEGIN CURSOR (zsh + nvim + tmux) ###

### https://superuser.com/a/1501674/1012390

bindkey -v
export KEYTIMEOUT=1

# Change cursor with support for inside/outside tmux
function _set_cursor() {
    if [[ $TMUX = '' ]]; then
      echo -ne $1
    else
      echo -ne "\ePtmux;\e\e$1\e\\"
    fi
}

function _set_block_cursor() { _set_cursor '\e[2 q' }
function _set_beam_cursor() { _set_cursor '\e[6 q' }

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
      _set_block_cursor
  else
      _set_beam_cursor
  fi
}
zle -N zle-keymap-select
# ensure beam cursor when starting new terminal
precmd_functions+=(_set_beam_cursor) #
# ensure insert mode and beam cursor when exiting vim
zle-line-init() { zle -K viins; _set_beam_cursor }

### END CURSOR (zsh + nvim + tmux) ###

###

### Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M viins '^e' edit-command-line
bindkey -M vicmd '^e' edit-command-line

###

# set -o physical (cd into symlinks like into the real values (see https://unix.stackexchange.com/a/371147/332452))
setopt CHASE_LINKS

# Case INsensitive autocompletions
setopt MENU_COMPLETE

# allow comments in command-line commands
# see https://stackoverflow.com/a/11873793
setopt interactivecomments

#
#setopt nomenucomplete noautomenu
setopt nomenucomplete

# "shopt -s expand_aliases" in bash equivalent.
# see https://stackoverflow.com/a/23259088/9285308
setopt aliases

# Enable colors and change prompt:
autoload -U colors && colors
# without __git_prompt
#export PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# with __git_prompt
#export PS1='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~ %c$(__git_ps1 " (%s)")%{$fg[red]%}]%{$reset_color%}$%b '
#export PS1='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%1~%{$reset_color%}$(__git_ps1 " (%s)")%{$fg[red]%}]%{$reset_color%}$%b '
#PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '

#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

#export PS1='\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 15)\]\[$(__git_ps1 " (%s)")\]\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]'

# add the git prompt to precmd, as recommended in
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
# (this is the faster version and it also allows colors!)
[ -f "$HOME/.config/git/git-prompt.sh" ] && source "$HOME/.config/git/git-prompt.sh"
precmd () {
	# the __git_ps1
	# pre
	# git's status
	# post
	# wrap git's status

	__git_ps1 \
	"%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%1~%{$reset_color%}" \
	"%{$fg[red]%}]%{$reset_color%}$%b " \
	" (%s)"
}

# # echo -ne '\e[5 q' # Use beam shape cursor on startup.
# # preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

bindkey -s -M viins '^w' 'exit\n'
bindkey -s -M vicmd '^w' 'exit\n'

bindkey -s -M viins '^[w' 'exit\n'
bindkey -s -M vicmd '^[w' 'exit\n'

## bindkey -s '^a' 'bc -l\n'

bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

### tmux
bindkey -s '^s' 'tmux a -t 0 2>/dev/null || tmux new -s 0\n'
bindkey -s -M viins '^s'  'tmux a -t 0 2>/dev/null || tmux new -s 0\n'
bindkey -s -M vicmd '^s' 'tmux a -t 0 2>/dev/null || tmux new -s 0\n'

# unbind -- https://unix.stackexchange.com/a/285210/332452
bindkey -r "^[/"
bindkey -r "^_"
##bindkey -r "^\\"
bindkey -r "\^\\\^"
###

# git-prompt.sh configs
# More info @ ~/.config/git-prompt.sh & ~/.config/git-completion.bash
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
#export GIT_PS1_SHOWUPSTREAM="auto verbose name"
#GIT_PS1_SHOWUPSTREAM="auto verbose"
GIT_PS1_SHOWUPSTREAM="verbose"
GIT_PS1_DESCRIBE_STYLE="default"

### ARCH ###

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[ShiftTab]}"  ]] && bindkey -- "${key[ShiftTab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start {
		echoti smkx
	}
	function zle_application_mode_stop {
		echoti rmkx
	}
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

###
# history search - see https://wiki.archlinux.org/index.php/Zsh#History_search

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

###

# print how long a command took if it took longer than `3` seconds
# http://zsh.sourceforge.net/Doc/Release/Parameters.html
export REPORTTIME=3

# ported from .bashrc #

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export GPG_TTY="$(tty)"
#export PASSWORD_STORE_DIR="$HOME/.password-store"

### vi mode improved!

autoload -U select-quoted; zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done


autoload -U select-bracketed; zle -N select-bracketed
for m in visual viopp; do
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $m $c select-bracketed
    done
done


autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

###

### block cursor



###

### add missing vim hotkeys
# http://zshwiki.org/home/zle/vi-mode
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char  #backspace

### history search in vim mode
# http://zshwiki.org./home/zle/bindkeys#why_isn_t_control-r_working_anymore
# ctrl+r to search history
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

bindkey -M menuselect '^M' .accept-line

### --- ###

#source ~/.config/zsh/completions/_deno

# Load zsh-syntax-highlighting; should be last. https://wiki.archlinux.org/index.php/Zsh#Fish-like-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

case "$OSTYPE" in
	# https://unix.stackexchange.com/a/446380/332452
	$~darvin*)
		# iterm2
		test -e "${ZDOTDIR}/.iterm2_shell_integration.zsh" && source "${ZDOTDIR}/.iterm2_shell_integration.zsh"
	;;
		*)
	;;
esac

[ -z "$TMUX" ] && {
	bootTimeDuration=$((($(date +%s%N) - $bootTimeStart)/1000000))
	printf "$bootTimeDuration ms\n"
}

