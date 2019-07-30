#!/usr/bin/bash

source _vars.inc.sh

#install base packages

echo "===========INSTALLING BASE SYSTEM ===================="
pacstrap /mnt base

echo "does everything look ok?"
continueyn

#create the fstab
genfstab -L -p /mnt >> /mnt/etc/fstab

cat /mnt/etc/fstab
echo "still alright?"
continueyn

echo "ok we're gonnna rewrite the fstab a little"
sed -i s+LABEL=swap+/dev/mapper/swap+ /mnt/etc/fstab
echo "swap	/dev/disk/by-partlabel/ENCSYS	/dev/urandom	swap,offset=2048,cipher=aes-xts-plain64,size=256" >> /mnt/etc/cryptswap

less /mnt/etc/fstab
echo "----- and /etc/cryptswap ----"
less /mnt/etc/cryptswap

cp -a install_phase2.sh /mnt/tmp/install_phase2.sh
cp -a onsystem_config.sh /mnt/tmp/onsystem_config.sh
cp -aR custom /mnt/tmp/custom

echo "booting new system, run `/tmp/install_phase2.sh` from the new environment to complete base arch installation"
echo "hold on to your hat"
continueyn

systemd-nspawn -bD /mnt
