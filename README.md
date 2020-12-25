# The Voidrice (Kipras' fork of [Luke Smith's dotfiles](https://github.com/lukesmithxyz/voidrice))

These are the dotfiles deployed by [LARBS](https://larbs.xyz), as seen on [Luke's YouTube channel](https://youtube.com/c/lukesmithxyz).

- Very useful scripts are in `~/.local/bin/`
- Settings for:
	- vim / nvim / doom emacs (text editors)
	- zsh (shell)
	- tmux (terminal multiplexer)
	- i3wm/i3-gaps (window manager)
	- i3blocks (status bar)
	- sxhkd (general key binder)
	- ranger / lf / vifm (file managers)
	- mpd/ncmpcpp (music)
	- sxiv (image/gif viewer)
	- mpv (video player)
	- other stuff like xdg default programs, inputrc and more, etc.
- We try to minimize what's directly in `$HOME` so:
	- Most configs that can be in `~/.config/` are.
	- Some environmental variables have been set in `~/.profile` to move configs into `~/.config/`
- Bookmarks in text files used by various scripts (like `~/.local/bin/shortcuts`)
	- File bookmarks in `~/.config/files`
	- Directory bookmarks in `~/.config/directories`

## Not included here

- VSCode config (settings, keybinds, extensions, themes etc.): https://gist.github.com/kiprasmel/de9160a0602463fb752f2d84d7aa4fd8

- st ([Kipras'](https://github.com/kiprasmel/st) or [Luke's](https://github.com/lukesmithxyz/st)) - the terminal emulator assumed to be used by these dotfiles

- [mutt-wizard (`mw`)](https://github.com/lukesmithxyz/mutt-wizard) - a terminal-based email system that can store your mail offline without effort

## Install these dotfiles

Use [LARBS](https://larbs.xyz) to autoinstall everything:

```sh
curl -LO larbs.xyz/larbs.sh
```

inspect the script, and then

```sh
./larbs.sh -r https://github.com/kiprasmel/voidrice
```

or clone the repo files directly to your home directory and install [the prerequisite programs](https://github.com/kiprasmel/LARBS/blob/master/progs.csv).
