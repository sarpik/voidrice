#!/usr/bin/env bash
# cputils.config.bash

export CPP_COMPILER_DEFAULT_ARGS="-std=c++17 -g -Wall"
export INPUT_CACHE_FILE_EXTENSION="cpp.txt"
export HIDE_EXAMPLES=1

create_output_file_name() {
	FILENAME_EXTLESS="$1"
	EXT="$2"

	# printf "a"
	# printf "a.out"
	# printf "$FILENAME_EXTLESS"
	# printf "$FILENAME_EXTLESS.out"
	printf "$FILENAME_EXTLESS.$EXT.out"
}
export -f create_output_file_name

# we attempt to handle at least the most common clipboard tools here.
# add yours if it's missing
# (see https://stackoverflow.com/questions/749544/pipe-to-from-the-clipboard-in-bash-script
#  and https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script )
#
# it'd be great if you could create a pull request too!
# https://github.com/kiprasmel/cputils/blob/master/cputils-run
#

export STATUS_CLIPBOARD_FAILURE=2   # likely to be empty, thought not all tools error in this case :/
export STATUS_CLIPBOARD_UNHANDLED=3

paste_from_clipboard() {
	return 0

	  if command -v xclip   &>/dev/null; then
		                xclip -selection clipboard -o 2>/dev/null && return 0 \
		             || xclip -selection primary   -o 2>/dev/null && return 0 \
		             ||                                              return $STATUS_CLIPBOARD_FAILURE
	elif command -v xsel    &>/dev/null; then xsel --clipboard    || return $STATUS_CLIPBOARD_FAILURE
	elif command -v pbpaste &>/dev/null; then pbpaste             || return $STATUS_CLIPBOARD_FAILURE
	elif ls /dev/clipboard  &>/dev/null; then cat /dev/clipboard  || return $STATUS_CLIPBOARD_FAILURE
	# elif ... # add your's!
	else return $STATUS_CLIPBOARD_UNHANDLED
	fi

	return $?
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

# create a hash from stdin.
# used to check if a source file
# should be recompiled or not
create_hash() {
	# return 1  # comment out this line to enable and choose the appropriate method

	if [ -z "$1" ]; then
		# stdin

		openssl dgst -sha256 -r      | awk '{ print $1 }'
		# sha256sum - | awk '{ print $1 }'
	else
		# $1

		openssl dgst -sha256 -r "$1" | awk '{ print $1 }'
		# sha256sum "$1" | awk '{ print $1 }'
	fi

	# note: might be different for Mac,
	# see https://stackoverflow.com/a/20217018/9285308
}
export -f create_hash

