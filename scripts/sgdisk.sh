#!/usr/bin/bash
#clean any previous failed runs

if [[ $system_part_fstype == "btrfs" ]]; then
  umount /mnt/boot
  umount /mnt/home
  umount /mnt/.snapshots
fi

umount /mnt && cryptsetup close /dev/mapper/encsys
swapoff -a && cryptsetup close /dev/mapper/swap

source _vars.inc.sh
echo "############### ALL TARGET PARTITIONS UNMOUNTED AND CLOSED ################"

continueyn

echo "clear and create new partition table"

sgdisk --clear
sgdisk --mbrtogpt
sgdisk --zap-all $target_device
sgdisk --clear \
  --new=1:0:+500MiB --typecode=1:ef00 --change-name=1:EFI\
  --new=2:0:+8GiB --typecode=1:8200 --change-name=2:ENCSWAP\
  --new=3:0:+250GiB --typecode=8309 --change-name=3:ENCSYS\
  $target_device
sgdisk --sort

echo ".......partition table created!"

gdisk -l $target_device

echo ".......end of partition table"

#/dev/sda1 : start=        2048, size=     1024000, type=ef
#/dev/sda2 : start=   608258048, size=    16777216, type=82
#/dev/sda3 : start=     1026048, size=   607230361, type=83
