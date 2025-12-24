# NanoPwnBox

Nano Pwn Box using NanoPi R3S and Debian 13

## SD Card Preparation

Prepare the micro SD Card from another computer.

Get https://dl.armbian.com/nanopi-r3s-lts/Trixie_edge_minimal

```sh
# Get the necessary img

xz -d Armdebian[...].img.xz

# identify the disk and unmount it
fdisk -l
umount /dev/sdXXXXXX
# copy the img to the disk
sudo dd if=sd-card.img of=/dev/sdXXX # ...where /dev/sdXXX is your SD card

# MacOS equivalent
diskutil list 
diskutil unmountDisk /dev/disk4
sudo dd if=Armbian_25.11.1_Nanopi-r3s-lts_trixie_edge_6.18.0-rc6_minimal.img of=/dev/rdisk4 bs=4m status=progress
diskutil eject /dev/disk4
```


## OS Setup

```sh
# oneliner using the attached setup.sh
```

## Ressources

- https://www.armbian.com/nanopi-r3s/
- https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R3S#Work_with_Debian_Core
- https://medium.com/@cihananthony/pisquirrel-the-open-source-red-teaming-wiretap-and-dropbox-cc5ddc96e05d
- R2S Debian image : https://sd-card-images.johang.se/boards/nanopi_r2s.html