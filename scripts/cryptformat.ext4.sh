#!/usr/bin/bash
#commented out for testing
#make the efi partition
umount /mnt
swapoff

echo "################ FORMATTING EFI DISK #################"
mkfs.fat -F32 -n EFI /dev/disk/by-partlabel/EFI
echo ""
echo ""
echo "------------------------------------------------------"

#emcrypt the system part
echo "############ INITIALIZING SYSTEM ENCRYPTION ##########"
cryptsetup luksFormat --align-payload=8192 -s 256 -c aes-xts-plain64 /dev/disk/by-partlabel/ENCSYS
mkfs.fat -F32 -n EFI /dev/disk/by-partlabel/EFI

echo "------------------------------------------------------"

#open the encrypted disk
echo "################ OPENING SYSTEM DISK  #################"
cryptsetup open /dev/disk/by-partlabel/ENCSYS system

echo "------------------------------------------------------"

#make encrypted swap
echo "############# INITIALIZING SWAP ENCRYPTION ############"
cryptsetup open --type plain --key-file /dev/urandom  /dev/disk/by-partlabel/ENCSWAP swap

mkswap -L swap /dev/mapper/swap
swapon -L swap

echo "------------------------------------------------------"

###ext4  specific
#make system partition
echo "################ FORMATTING SYSTEM DISK #################"
mkfs.ext4 -F -L system /dev/mapper/system

echo "------------------------------------------------------"

echo "################ CREATING SUBVOLUMES ####################"
mount -t ext4 LABEL=system /mnt

echo "------------------------------------------------------"

mkdir /mnt/home /mnt/boot

### - EXT4 specific
mount LABEL=EFI /mnt/boot

echo "------------------------------------------------------"

echo "###########!!! FILESYSTEM BUILD COMPLETE !!!#############"

lsblk
