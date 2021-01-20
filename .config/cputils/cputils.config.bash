#!/usr/bin/env bash
# cputils.config.bash

open_with_editor() {
	# exit 0 # delete this line and choose your editor if you want to

	nvim "$1"
	# vscodium "$1"

	# emacs "$1"
	# geany "$1" &
	# code "$1"
}
export -f open_with_editor

