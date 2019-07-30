#!/usr/bin/bash

##setup system specific variables
target_device=/dev/sda
system_part=${target_device}3
efi_part=${target_device}1
swap_part=${target_device}2
system_part_fstype=btrfs

## setup partition table
#./sgdisk.sh
`echo "running sgdisk"`
#./cryptsetup.sh
echo "running cryptsetup.sh"
#./baseinstall.sh
echo "running baseinstall.sh"


