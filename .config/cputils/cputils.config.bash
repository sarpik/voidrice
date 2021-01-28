#!/usr/bin/env bash
# cputils.config.bash

#
# we attempt to handle at least the most common clipboard tools here.
# add yours if it's missing
# (see https://stackoverflow.com/questions/749544/pipe-to-from-the-clipboard-in-bash-script
#  and https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script )
#
# it'd be great if you could create a pull request too!
# https://github.com/kiprasmel/cputils/blob/master/cputils-run
#
paste_from_clipboard() {
	if   command -v xclip   &>/dev/null; then printf "$(xclip -selection clipboard -o || xclip -selection primary -o)"
	elif command -v pbpaste &>/dev/null; then printf "$(pbpaste)"
	elif command -v xsel    &>/dev/null; then printf "$(xsel --clipboard)"
	elif ls /dev/clipboard  &>/dev/null; then printf "$(cat /dev/clipboard)"
	else return 1
	fi
}
export -f paste_from_clipboard

open_with_editor() {
	# return 1 # delete this line and choose your editor if you want to

	nvim "$1"
	# vscodium "$1"

	# emacs "$1"
	# geany "$1" &
	# code "$1"
}
export -f open_with_editor

#
# create a hash of a source file,
# so that it will not be recompiled
# if nothing has changed
#
create_hash() {
	# return 1  # comment out this line to enable and choose the appropriate method
	
	printf "$(sha256sum "$1" | awk '{ print $1 }')"
	# printf "$(openssl dgst -sha256 -r "$1" | awk '{ print $1 }')"

	# note: might be different for Mac, see https://stackoverflow.com/a/20217018/9285308
}


INPUT_CACHE_FILE_EXTENSION="txt"
export $INPUT_CACHE_FILE_EXTENSION

