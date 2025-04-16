# Arch Install Scripts Manual

## preface

This is a collection of scripts to automate the installation of arch linux. They were born of frustration after attempting to install black arch on an older machine. Black arch had an install script, but it does not work. I began manually installing but had trouble with booting the encrypted drive and got tired of typing in the earlier steps over and over again.

I got the impression the black arch installer was broken by design
by design with the intent to inspire people to dissect and gain an understanding. I will try to preserve this important element in these scripts and make sure there's plenty of broken, poorly designed, hacked together shit that only makes sense to me. And like many of the solutions I attpt to make things easier, it really just made it more difficult. If you have the misfortune of finding this project thinking you'll script kiddie your way through this OS install, you'll probably spend years unlearning all of my fundamental misunderstandings of computer science.

Hope this is useful to someone.

I imagine at this point it's only use is as documentation providing a bit of insight into the process of installing Arch Linux. 

That's essentially what I created it for, as a journal of my attempts to install blackarch. 

In the end I did what many posts recommend against and guarantee will result in an unrecoverable system after several rounds of updates. I simply [added the blackarch repository to Manjaro as described in this article](https://infosecjunky.com/installing-blackarch-tools-in-manjaro/). My system never became unusable as a result, but it should be acknowledged that this is not the correct way to do things as this repository represents the entire blackarch distribution and there could be cases where dependencies get all messed up as a result.

I've since read that it is preferable to [add the archstrike repository to manjaro or arch](https://archstrike.org/wiki/setup) if you want access to this selection of pentesting tools 

And if you're new to security and pentesting and ended up here through your searches maybe stumbling around aimlessly seeking some sort of direction but not finding any... allow me to recommend that which was recommended to me. [This may become your new favorite video game.](https://picoctf.org) And if not, I don't know what to tell you. If learning computer science isn't fun for you, I imagine you would need to be a special sort of masochist to be any kind of computer scientist. Here are some more gamified cybersecurity learning websites if you enjoyed picoCTF here are a bunch more links (in no particular order) to similar sites where you will learn cybersecurity concepts through a variety of interactive challenges and the like. 

- [picoCTF.org](https://picoctf.org)
- [HACKTHEBOX](https://www.hackthebox.com)
- [TryHackMe](https://tryhackme.com)
- [RingZer0CTF](https://ringzer0ctf.com/)
- [Bugcrowd University](https://www.bugcrowd.com/resources/levelup/)
- [UnderTheWire](https://underthewire.tech)
- [OverTheWire](https://overthewire.org/wargames/)
- [VulnHub](https://www.vulnhub.com/)
- [RootMe](https://www.root-me.org/?lang=en)
- [PortSwigger](https://portswigger.net/web-security)
- [CTF Learn](https://ctflearn.com/)
- [CrackTheLab](https://www.crackthelab.com/)
- [OWASP's WebGoat](https://owasp.org/www-project-webgoat/)
- [CTFTime](https://ctftime.org/)
- [CyberDefenders](https://cyberdefenders.org/)
- [DefendTheWeb.net](https://defendtheweb.net/dashboard)
- [CTF365.com](https://ctf365.com)
- [CTF101.com](https://ctf101.com)
- [Pentesterlab.com](https://pentesterlab.com)
- [247ctf.com](https://247ctf.com)
- [battleh4ck](https://seela.io/battleh4ck/)
- [Ethernaut](https://ethernaut.openzeppelin.com/)
- [crackmes.one](https://crackmes.one/)
- [pwnable.tw](https://pwnable.tw/)
- [pwnable.kr](https://pwnable.kr/)
- [cryptohack](https://cryptohack.org/)
- [exploit.education](https://exploit.education/)
- [cryptopals.com](https://cryptopals.com/)
- [w3challs](https://w3challs.com/)
- [Aman Hardikar's Pentesting Lab](https://www.amanhardikar.com/mindmaps/Practice.html)
- [alf.nu](https://www.alf.nu/alert1)
- [hacksplaining](https://www.hacksplaining.com/)
- [Hacker101 CTF](https://ctf.hacker101.com/)
- [CMDChallenge](https://cmdchallenge.com/)
- [hacking-lab.com](https://hacking-lab.com/)
- [capturetheflag.withgoogle.com](https://capturetheflag.withgoogle.com/)
- [immersivelabs.com](https://www.immersivelabs.com/)
- [SMASHTHESTACK.ORG](https://www.smashthestack.org/)
- [Holiday Hack Challenge](https://www.holidayhackchallenge.com)
- [Skill Dive](https://ine.com/dive)

  
- You may also find something interesting to [watch or listen to on infocon.org](https://infocon.org), and site that provides audio and video archives of cybersecurity conference presentations. 

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
