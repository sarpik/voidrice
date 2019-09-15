# Kipras's fork of [Luke's](https://github.com/LukeSmithxyz/voidrice) GNU/Linux Dotfiles

These are *my* (Kipras's) dotfiles! The name of the repo, "voidrice", came from the fact they were originally on Luke's Void Linux machine, but these files are distro-independent. In fact, Luke now pushes changes from his X200 running Parabola or his X220 running Arch.

## Programs whose configs can be found here

+ i3 (i3-gaps)
+ ~~Xresourses/Xdefaults settings~~ Now moved to [my terminal (st) build](https://github.com/sarpik/st) ([or Luke's](https://github.com/lukesmithxyz/st)) which uses them
+ vim
+ bash
+ vifm
+ ~~mutt/msmtp/offlineimap~~ Now moved to [LukeSmithxyz/mutt-wizard](https://github.com/LukeSmithxyz/mutt-wizard)
+ calcurse
+ ncmpcpp and mpd (my main music player)
+ mpv
+ neofetch
+ And many little scripts I use filed in the `~/.local/bin/` directory

## More documentation

There's a full .pdf write-up of the repository [here: https://larbs.xyz/larbs_readme.pdf](https://larbs.xyz/larbs_readme.pdf).

Or, if you actually installed my/Luke's dotfiles, you can just press `Super+F1` to
show the same document offline.

In the system, you can also press `Super+Shift+e` to watch tutorial videos on
different programs used. See [Luke's YouTube channel](https://youtube.com/c/LukeSmithxyz) for more.

The command `getkeys` will also show basic key binds for different programs.

## Dynamic Configuration Files

Store your favorite or high-traffic directories in `~/.config/bmdirs` or your most
important config files in `~/.config/bmfiles` with keyboard shortcuts. When you add
things to theses files my vimrc will automatically run `shortcuts` which will
dynamically generate shortcuts for these in bash, ranger and optionally
qutebrowser and fish.

## Like Luke's rice?

Feel free to add other suggestions and Luke may implement them.

Luke has a job, but every penny he get from followers or subscribers is more incentive to perfect what he's doing.
You can donate to him at [https://paypal.me/LukeMSmith](https://paypal.me/LukeMSmith).
Donations are earmarked for whatever the donator wants, usually to go to funds for buying new equipment for the [YouTube channel](https://youtube.com/c/LukeSmithxyz).

# "Dependencies" and programs used

The programs I use here are always changing, but luckily you can just look at the installation list for [LARBS](http://larbs.xyz) here:

List of programs installed by LARBS, including optional packages:

* [Kipras's](https://github.com/sarpik/LARBS/blob/master/progs.csv)
* [Luke's](https://github.com/LukeSmithxyz/LARBS/blob/master/archi3/progs.csv)

`A` marks programs in the AUR, `G` marks git repositories.
