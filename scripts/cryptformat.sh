#!/usr/bin/bash
#commented out for testing
#make the efi partition

echo "################ FORMATTING EFI DISK #################"
mkfs.fat -F32 -n EFI /dev/disk/by-partlabel/EFI
echo "------------------------------------------------------"
continueyn
#emcrypt the system part
echo "############ INITIALIZING SYSTEM ENCRYPTION ##########"
cryptsetup luksFormat --align-payload=8192 -s 256 -c aes-xts-plain64 /dev/disk/by-partlabel/ENCSYS
mkfs.fat -F32 -n EFI /dev/disk/by-partlabel/EFI
echo "------------------------------------------------------"
continueyn

#open the encrypted disk
echo "################ OPENING SYSTEM DISK  #################"
cryptsetup open /dev/disk/by-partlabel/ENCSYS system
echo "------------------------------------------------------"
continueyn

#make encrypted swap
echo "############# INITIALIZING SWAP ENCRYPTION ############"
cryptsetup open --type plain --key-file /dev/urandom  /dev/disk/by-partlabel/ENCSWAP swap
mkswap -L swap /dev/mapper/swap
swapon -L swap
echo "------------------------------------------------------"
continueyn

#make system partition
echo "################ FORMATTING SYSTEM DISK #################"
mkfs.btrfs --force --label system /dev/mapper/system
echo "------------------------------------------------------"
continueyn

if [[ $system_part_type == "btrfs" ]]; then
  ###BEGIN BTRFS SPECIFIC
  echo "################ CREATING SUBVOLUMES ####################"
  mount -t btrfs LABEL=system /mnt
  btrfs subvolume create /mnt/root
  btrfs subvolume create /mnt/home
  btrfs subvolume create /mnt/snapshots
  umount -R /mnt
  echo "------------------------------------------------------"
  continueyn

  echo "################# MOUNTING SUBVOLUMES ###################"
  mount -t btrfs -o subvol=root,defaults,x-mount,compress=lzo,noatime LABEL=system /mnt
  echo "root... \n"
  mkdir /mnt/home
  mount -t btrfs -o subvol=home,defaults,x-mount,mkdir,compress=lzo,noatime LABEL=system /mnt/home

  echo "home... \n"
  mkdir /mnt/.snapshots

  echo ".snapshots \n"
  mount -t btrfs -o subvol=snapshots,defaults,x-mount,mkdir,compress=lzo,noatime LABEL=system /mnt/.snapshots

  echo "------------------------------------------------------"
  continueyn
  ### END BTRFS SECTION
elif [[ $system_part_type == "ext4" ]]; then
  ###ext4  specific
  #make system partition
  echo "################ FORMATTING SYSTEM DISK #################"
  mkfs.ext4 -F -L system /dev/mapper/system

  echo "------------------------------------------------------"

  echo "################ CREATING SUBVOLUMES ####################"
  mount -t ext4 LABEL=system /mnt

  echo "------------------------------------------------------"

  mkdir /mnt/home /mnt/boot
else
  echo "filesystem $system_part_type not yet supported"
fi

echo "############### MOUNTING EFI PART #######################"
mkdir /mnt/boot
mount LABEL=EFI /mnt/boot
echo "------------------------------------------------------"
continueyn


echo "###########!!! FILESYSTEM BUILD COMPLETE !!!#############"
lsblk
