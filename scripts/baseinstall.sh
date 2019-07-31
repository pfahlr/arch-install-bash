#!/usr/bin/bash
# <[A]>
source _vars.inc.sh

#install base packages

echo "|=============  INSTALLING BASE SYSTEM   =====================================|"
pacstrap /mnt base

echo "... does everything look ok?:"
continueyn
# </[A]>

# ? <[B] maybe this section makes more sense before pactrap> ?
#create the fstab
genfstab -L -p /mnt >> /mnt/etc/fstab

cat /mnt/etc/fstab
echo "... here's etc/fstab: "
continueyn

echo "... ok we're gonnna rewrite it a little.:"
command = "sed -i s+LABEL=swap+/dev/mapper/swap+ /mnt/etc/fstab"
echo "...running: $command:"
eval $command

echo "swap	/dev/disk/by-partlabel/ENCSWAP	/dev/urandom	swap,offset=2048,cipher=aes-xts-plain64,size=256" >> /mnt/etc/cryptswap

less /mnt/etc/fstab
echo "---------- and /etc/cryptswap ----"
less /mnt/etc/cryptswap
# </[B]>

# <[C]>
cp -a install_phase2.sh /mnt/tmp/install_phase2.sh
cp -a onsystem_config.sh /mnt/tmp/onsystem_config.sh
cp -aR custom /mnt/tmp/custom

echo "... booting new system, run `/tmp/install_phase2.sh` from the new environment to complete base arch installation:"
echo "... hold on to your hat, your system is about to be completely fucked up:"
continueyn

systemd-nspawn -bD /mnt
# </[C]>
