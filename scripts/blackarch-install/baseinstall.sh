#!/usr/bin/bash
# <[A]>
source _vars.inc.sh
if [[ $debug_echo ]]; then
#  set -x
fi

#install base packages
echo "|=============  INSTALLING BASE SYSTEM   =====================================|"
pacstrap /mnt base

if [[ $debug_step ]]; then
  echo "... does everything look ok?:"
  continueyn
fi
# </[A]>

# ? <[B] maybe this section makes more sense before pactrap> ?
#create the fstab
genfstab -L -p /mnt >> /mnt/etc/fstab

echo "... /etc/fstab: "
cat /mnt/etc/fstab

if [[ $debug_step ]]; then
  continueyn
fi

echo "... ok we're gonnna rewrite it a little.:"
sed -i s+LABEL=swap+/dev/mapper/swap+ /mnt/etc/fstab
eval $command

echo "swap	/dev/disk/by-partlabel/ENCSWAP	/dev/urandom	swap,offset=2048,cipher=aes-xts-plain64,size=256" >> /mnt/etc/cryptswap
echo "edited /etc/fstab"
cat /mnt/etc/fstab
echo "... /etc/cryptswap:"
cat /mnt/etc/cryptswap

if [[ $debug_step ]]; then
  continueyn
fi
# </[B]>

# <[C]>
cp -a run-install-phase2.sh /mnt/tmp/run-install-phase2.sh
cp -a onsystem-config.sh /mnt/tmp/onsystem-config.sh
cp -aR custom /mnt/tmp/custom

echo "... booting new system, run `/tmp/install_phase2.sh` from the new environment to complete base arch installation:"
echo "... hold on to your hat, your system is about to be completely fucked up:"

if [[ $debug_step ]]; then
  continueyn
fi

systemd-nspawn -bD /mnt
# </[C]>
