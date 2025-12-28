# NanoPwnBox

Red Team Nano Pwn Box using NanoPi R3S, Debian, Tailscale and Exegol.  
4G USB Stick config setup later on.

## SD Card Preparation

Prepare the micro SD Card from another computer.

1. Download the Debian13 compatible image from https://www.armbian.com/nanopi-r3s/ :
```sh
wget https://dl.armbian.com/nanopi-r3s-lts/Trixie_edge_minimal -o debian13-nanopi.img.xz
```

2. Decompress it :
```sh
xz -d debian13-nanopi.img.xz
```

3. Identify the SD card and unmount it :
```sh
fdisk -l
umount /dev/sdXX
```

4. Copy the img to the SD Card (replace `/dev/sdXX` with yours) :
```sh
sudo dd if=sd-card.img of=/dev/sdXX
```

### On macOS

```sh
# Example using /dev/disk4 
diskutil list 
diskutil unmountDisk /dev/disk4
sudo dd if=sd-card.img of=/dev/rdisk4 bs=4m status=progress
diskutil eject /dev/disk4
```

## Pwn Box Setup

After booting the NanoPi from the prepared SD card image, follow the initial setup instructions on the device to create a new user. This step is mandatory before proceeding.

Once the user is created and you can log in as that user, continue with the following:

1. Download the main setup script from this repository:

```sh
curl -L -o setup.sh https://raw.githubusercontent.com/Kyrd0x/NanoPwnBox/refs/heads/main/setup.sh
```

1. Make the script executable and review it:

```sh
chmod +x setup.sh
cat setup.sh
```

3. Run the setup script with sudo privileges:

```sh
sudo ./setup.sh
```

This script will do the following:
- Installs essential packages
- Configures network bridge for port mirroring
- Installs Tailscale VPN

**TODO**: hardening, 4G support, logging & monitoring, persistence, network configuration

## Tailscale & Exegol Setup

Start a new Exegol container with the following command :

```sh
exegol start pwnbox free
```

Next, configure Tailscale inside the container. To do this, retrieve the auth key from the Tailscale Admin Panel:  
**Machines > Add device > Linux server**  
Here grab the `auth-key` from the **Generate install script** section

Then, inside the container, run :
```sh
# Start the tailscaled daemon with user-space networking and SOCKS5 proxy
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &>/dev/null &
```

Join your Tailscale network and accept advertised routes with:
```sh
tailscale up --auth-key=tskey-XXXXX --accept-routes
```

Copy the auth key (`tskey-XXXXX`) from the above command, and on your NanoPwnBox host, join your Tailscale network using:

```sh
sudo tailscale up --auth-key=tskey-XXXXX
```

You should now see both devices listed in your Tailscale Admin Console.

### Advertising subnets during engagements

To advertise a subnet (for example, `172.16.10.0/24`), run:

```sh
sudo tailscale up --advertise-routes=172.16.10.0/24
```

Then, validate the advertised routes in the Tailscale Admin Console by navigating to the machine and editing its route settings.

## Ressources

- https://docs.exegol.com
- https://www.armbian.com/nanopi-r3s/
- https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R3S#Work_with_Debian_Core
- https://medium.com/@cihananthony/pisquirrel-the-open-source-red-teaming-wiretap-and-dropbox-cc5ddc96e05d
- R2S Debian image : https://sd-card-images.johang.se/boards/nanopi_r2s.html