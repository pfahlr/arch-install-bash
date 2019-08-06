#!/usr/bin/bash

source ./_vars.inc.sh

if [[ $debug_echo ]]; then
  set -x
fi

echo $system_part_fstype
echo "|============= CLEANING UP DETRITUS =========================================|>"

#clean any previous failed runs
umount /mnt/boot
umount /mnt/home
umount /mnt/.snapshots

umount /mnt
cryptsetup close /dev/mapper/system
swapoff -a
cryptsetup close /dev/mapper/swap

echo "|============= ALL TARGET PARTITIONS UNMOUNTED AND CLOSED ===================|>"
echo "target device: $target_device"

continueyn

echo "... clear and create new partition table:"

sgdisk --clear
sgdisk --mbrtogpt
sgdisk --zap-all $target_device

sgdisk --clear \
  --new=$efinum:0:+500MiB --typecode=1:ef00 --change-name=1:EFI\
  --new=$swpnum:0:+8GiB --typecode=1:8200 --change-name=2:ENCSWAP\
  --new=$sysnum:0:+$system_part_size --typecode=8309 --change-name=3:ENCSYS\
  $target_device || exit; 

sgdisk --sort

echo ".......partition table created!:"

gdisk -l $target_device

lsblk --tree --output PATH,name,MOUNTPOINT,PARTLABEL,FSSIZE,FSTYPE,PARTUUID $target_device

echo ".......end of partition table:"

echo "|============= NEXT: run cryptformat.sh ======================================|>"

#/dev/sda1 : start=        2048, size=     1024000, type=ef
#/dev/sda2 : start=   608258048, size=    16777216, type=82
#/dev/sda3 : start=     1026048, size=   607230361, type=83
