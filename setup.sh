#!/bin/sh

DEVICE="/dev/mmcblk0"
MOUNTPOINT="/mnt/test"

echo "### Listing partitions on $DEVICE ###"
fdisk -l $DEVICE

echo "### Checking partitions content ###"

mkdir -p $MOUNTPOINT

for part in $(ls ${DEVICE}p* 2>/dev/null); do
  echo
  echo "Mounting partition $part..."
  mount $part $MOUNTPOINT 2>/dev/null
  if [ $? -ne 0 ]; then
    echo "Failed to mount $part (maybe already mounted or unsupported fs). Skipping."
    continue
  fi

  echo "Content of $part:"
  ls -l $MOUNTPOINT

  umount $MOUNTPOINT
done

echo "### Done ###"
