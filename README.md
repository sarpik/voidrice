# The Voidrice (Kipras's fork of [Luke Smith's dotfiles](https://github.com/lukesmithxyz/voidrice))

These are the dotfiles deployed by [LARBS](https://larbs.xyz), as seen on [Luke's YouTube channel](https://youtube.com/c/lukesmithxyz).

- Very useful scripts are in `~/.local/bin/`
- Settings for:
	- vim/nvim (text editor)
	- zsh (shell)
	- i3wm/i3-gaps (window manager)
	- i3blocks (status bar)
	- sxhkd (general key binder)
	- ranger (file manager)
	- lf (file manager)
	- mpd/ncmpcpp (music)
	- sxiv (image/gif viewer)
	- mpv (video player)
	- calcurse (calendar program)
	- tmux
	- other stuff like xdg default programs, inputrc and more, etc.
- Luke & I try to minimize what's directly in `$HOME` so:
	- All configs that can be in `~/.config/` are.
	- Some environmental variables have been set in `~/.zprofile` to move configs into `~/.config/`
- Bookmarks in text files used by various scripts (like `~/.local/bin/shortcuts`)
	- File bookmarks in `~/.config/files`
	- Directory bookmarks in `~/.config/directories`

## Want even more?

My setup is pretty modular nowadays.
I use several suckless programs that are meant to be configured and compiled by the user and I also have separate repos for some other things.
Check out their links:

- st ([Kipras's](https://github.com/sarpik/st) or [Luke's](https://github.com/lukesmithxyz/st)) - the terminal emulator assumed to be used by these dotfiles
- dwm ([Luke's](https://github.com/lukesmithxyz/dwm)) - the window manager Luke usually uses now which is fully compatible with this repo
- [mutt-wizard (`mw`)](https://github.com/lukesmithxyz/mutt-wizard) - a terminal-based email system that can store your mail offline without effort

## Install these dotfiles

Use [LARBS](https://larbs.xyz) to autoinstall everything:

```
curl -LO larbs.xyz/larbs.sh
```

Use `-r` to point to the correct dotfiles repo - either [Kipras's](https://github.com/sarpik/voidrice) or [Luke's](https://github.com/lukesmithxyz/voidrice)

or clone the repo files directly to your home directory and install the prerequisite programs - either [Kipras's](https://github.com/sarpik/LARBS/blob/master/progs.csv) or [Luke's](https://github.com/LukeSmithxyz/LARBS/blob/master/progs.csv).
