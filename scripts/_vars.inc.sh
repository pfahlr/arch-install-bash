###################################
#---------------------------------#
# setup system specific variables #
#---------------------------------#
###################################
continueyn() {
  local answer=''
  echo "continue[y/n]"
  read answer
  if [[ $answer == 'y' ]]; then
	  return 1
  elif [[ $answer == 'n' ]]; then
	  exit 0
  else  
	  echo "I don't understand"
	  continueyn
  fi

}

echo "setting system specific variables"

target_device=/dev/sda
echo "target device: $target_device"

efinum=1
swpnum=2
sysnum=3

system_part=${target_device}$sysnum
echo "system partition: $system_part"

efi_part=${target_device}${efinum}
echo "efi partition: $efi_part"

swap_part=${target_device}${swapnum}
echo "swap partition: $swp_part"

#fstype (e.g., ext4, btrfs, xfs, f2fs, zfs)
system_part_fstype=btrfs
echo "system filesystem format: $system_part_fstype"



