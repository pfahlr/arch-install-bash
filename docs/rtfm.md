# Arch Install Scripts Manual

## preface

This is a collection of scripts to automate the installation of arch linux. They were born of frustration after attempting to install black arch on an older machine. Black arch had an install script, but it does not work. I began manually installing but had trouble with booting the encrypted drive and got tired of typing in the earlier steps over and over again.

I got the impression the black arch installer was broken by design
by design with the intent to inspire people to dissect and gain an understanding. I will try to preserve this important element in these scripts and make sure there's plenty of broken, poorly designed, hacked together shit that only makes sense to me. And like many of the solutions I attpt to make things easier, it really just made it more difficult. If you have the misfortune of finding this project thinking you'll script kiddie your way through this OS install, you'll probably spend years unlearning all of my fundamental misunderstandings of computer science.

Hope this is useful to someone.

It's amazing I ever made any money in IT.

Well I'm not right now. I guess capitalism works sometimes and it got it right that I'm not worth anything.

Fuck Capitalism... Fuck writing pointless code that's only there to sell people bullshit or find out what bullshit they're gonna want to buy next month. I'm done with it. And if that means I gotta go sleep on the street
whatever. That isn't what I signed up for.

Enjoy,




---
### Setup
copy `_settings.inc.sh.default` to `_settings.inc.sh` and edit the variables
to fit your installation preferences.

#### variables
* **debug_step**=true - ask for confirmation at each step of the installation
* **debug_echo**=true - echo the commands run back to the console

* **target_device**=/dev/sda - the disk on which you intend to install arch. **everything will be
 deleted.** If you ran the scripts already. You probably figured this out. Maybe I
 shouldn't have left /dev/sda as the default. opps.

* **efinum**=1 - **swapnum**=2 - **sysnum**=3 - partition numbers for these 3 main partitions for
  your system. I realize presently they're not very usefult as options since the
  entire disk is nuked to begin the install, but later I, or *you* could add the
  multi boot stuff. Gotta have windows on there so you can boot it up every few
  month, watch it update for 3 hours, forget what thing that required some software
  that's only built for windows you needed to do, and then shut it back off.

* **system_part_size**=250GiB, well over half of your 1TB drive is probably took up
 by windows, so this is probably about right, and more than enough. EFI is hard coded
 to 500MB, and swap to 8GiB

* **system_part_fstype** - `btrfs`, `ext4`, and `redsea` are presently supported.

#### Recommended helper programs
You've got a little space in a liveboot enviornment, so you might want these programs
available

`pacman -Sy vim git tmux`

---

### Running the Installation

#### On live environment

  1) sgdisk.sh
  2) cryptformat.sh
  3) baseinstall.sh

#### Inside new environment
If all goes well the rest of the scripts should get copied to /tmp on the new
system it will be minimal and will not boot on it's own. There is much left to do.
And I haven't finished the automation, so that's all for now. My plan is to create a
system of hooks or something like that where different plugin type scripts can be
created to make all sorts of different systems for various purposes.

  4) onsystem-install.sh
---
