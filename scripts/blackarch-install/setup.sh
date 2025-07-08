#!/usr/bin/bash
#setup a few things in the live environment
#this does not apply to the final install and must be repeated on the 
#next boot. 

cd $(dirname $0)

echo "Enter a password for live root user"
passwd || (echo "could not set passwd... exiting" && exit)

pacman -Sy --noconfirm git vim tmux openssh || (echo "failed to install helper software, you will not be able to run tmux or ssh into the live installation environment. It's likely this is due to lack of internet connection, and an active connection is required to complete this install" && continueyn )

(systemctl enable sshd  && cp -a ../resources/sshd_config /etc/ssh/sshd_config) || exit

(systemctl start sshd || systemctl restart sshd) || (echo "failed to start ssh server... exiting" && exit)

cp -an ./_settings.inc.sh.default ./_settings.inc

