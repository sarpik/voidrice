# The following lines were added by compinstall

# bash bash compatibility mode - see https://github.com/eddiezane/lunchy/issues/57#issuecomment-448588918
autoload -U +X bashcompinit && bashcompinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' completer _expand _complete _ignored _correct _approximate rehash true
zstyle :compinstall filename '/home/kipras/.zshrc'
zstyle ':completion:*' menu select

autoload -Uz compinit promptinit
compinit
_comp_options+=(globdots)		# Include hidden files.

promptinit

prompt redhat

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
###HISTSIZE=1000			# current session
###SAVEHIST=999999999999	# history file

###
# history #
# see https://unix.stackexchange.com/a/273863

HISTFILE="$HOME/.cache/zsh/history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
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

###

setopt appendhistory autocd extendedglob nomatch notify
### do NOT set COMPLETE_ALIASES! See https://stackoverflow.com/a/20643204
unsetopt beep
bindkey -v
export KEYTIMEOUT=1

### Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

#echo -ne '\e[5 q' # Use beam shape cursor on startup.
#preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
_fix_cursor() {
   echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor)

###

### Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

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

[ -f "$HOME/.config/git/git-prompt.sh" ] && source "$HOME/.config/git/git-prompt.sh"
setopt PROMPT_SUBST

# Enable colors and change prompt:
autoload -U colors && colors
# without __git_prompt
#export PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# with __git_prompt
#export PS1='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~ %c$(__git_ps1 " (%s)")%{$fg[red]%}]%{$reset_color%}$%b '
export PS1='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%1~%{$reset_color%}$(__git_ps1 " (%s)")%{$fg[red]%}]%{$reset_color%}$%b '
#PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '

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


#export PS1='\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 15)\]\[$(__git_ps1 " (%s)")\]\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]'

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

# ported from .bashrc #

# https://github.com/github/hub/
if [ -f "$HOME/.config/git/hub.bash_completion" ]; then
	source "$HOME/.config/git/hub.bash_completion"
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export GPG_TTY="$(tty)"
export PASSWORD_STORE_DIR="$HOME/.password-store"

# load stuff
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

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
bindkey -M viins '^t' history-incremental-search-backward
bindkey -M vicmd '^t' history-incremental-search-backward

# Load zsh-syntax-highlighting; should be last. https://wiki.archlinux.org/index.php/Zsh#Fish-like-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

